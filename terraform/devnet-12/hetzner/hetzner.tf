////////////////////////////////////////////////////////////////////////////////////////
//                            TERRAFORM PROVIDERS & BACKEND
////////////////////////////////////////////////////////////////////////////////////////
provider "hcloud" {
  token = var.dencun_hcloud_token
}
////////////////////////////////////////////////////////////////////////////////////////
//                                        VARIABLES
////////////////////////////////////////////////////////////////////////////////////////
variable "dencun_hcloud_token" {
  type        = string
  description = "Hetzner Cloud API Token"
  sensitive   = true
}

variable "hcloud_ssh_key_fingerprint" {
  type    = string
  default = "d6:76:2d:9c:5b:33:80:ff:0f:09:a2:10:9b:58:7e:dc"
}

variable "hetzner_regions" {
  default = [
    "nbg1",
    "fsn1",
    "hel1"
  ]
}

////////////////////////////////////////////////////////////////////////////////////////
//                                        LOCALS
////////////////////////////////////////////////////////////////////////////////////////
locals {
  hetzner_network = {
    for region in var.hetzner_regions : region => {
      name     = "${var.ethereum_network}-${region}"
      ip_range = cidrsubnet(var.base_cidr_block, 8, index(var.hetzner_regions, region))
    }
  }
  hetzner_network_subnets = {
    for region in var.hetzner_regions : region => {
      zone     = "eu-central"
      ip_range = cidrsubnet(var.base_cidr_block, 8, index(var.hetzner_regions, region))
    }
  }
}

locals {
  hetzner_vm_groups = flatten([
    for vm_group in local.vm_groups :
    [
      for i in range(0, vm_group.count) : {
        group_name = "${vm_group.name}"
        id         = "${vm_group.name}-${i + 1}-arm"
        vms = {
          "${i + 1}" = {
            labels = "group_name:${vm_group.name},val_start:${vm_group.validator_start + (i * (vm_group.validator_end -
              vm_group.validator_start) / vm_group.count)},val_end:${min(vm_group.validator_start + ((i + 1) * (vm_group.validator_end -
            vm_group.validator_start) / vm_group.count), vm_group.validator_end)}"
            location     = try(vm_group.location, local.hcloud_default_location)
            size         = try(vm_group.size, local.hcloud_default_server_type)
            ansible_vars = try(vm_group.ansible_vars, null)
          }
        }
      }
    ]
  ])
}

locals {
  hcloud_default_location    = "nbg1"
  hcloud_default_image       = "debian-12"
  hcloud_default_server_type = "cax31"
  hcloud_global_labels = [
    "Owner:Devops",
    "EthNetwork:${var.ethereum_network}"
  ]
  #  hcloud_global_labels_list = [for k, v in local.hcloud_global_labels : "${k}=${v}"]

  # flatten vm_groups so that we can use it with for_each()
  hcloud_vms = flatten([
    for group in local.hetzner_vm_groups : [
      for vm_key, vm in group.vms : {
        id        = "${group.id}"
        group_key = "${group.group_name}"
        vm_key    = vm_key

        name         = try(vm.name, "${group.id}")
        ssh_keys     = try(vm.ssh_keys, [data.hcloud_ssh_key.main.id])
        location     = try(vm.location, try(group.location, local.hcloud_default_location))
        image        = try(vm.image, local.hcloud_default_image)
        server_type  = try(vm.size, local.hcloud_default_server_type)
        backups      = try(vm.backups, false)
        ansible_vars = try(vm.ansible_vars, null)

        labels = concat(local.hcloud_global_labels, try(split(",", group.labels), []), try(split(",", vm.labels), []))
      }
    ]
  ])
}

////////////////////////////////////////////////////////////////////////////////////////
//                                  HETZNER RESOURCES
////////////////////////////////////////////////////////////////////////////////////////
resource "hcloud_network" "main" {
  for_each = local.hetzner_network
  name     = try(each.value.name, "${var.ethereum_network}-${each.key}")
  ip_range = each.value.ip_range
}

resource "hcloud_network_subnet" "main" {
  for_each     = local.hetzner_network_subnets
  network_id   = hcloud_network.main[each.key].id
  type         = "cloud"
  network_zone = each.value.zone
  ip_range     = each.value.ip_range
}

data "hcloud_ssh_key" "main" {
  fingerprint = var.hcloud_ssh_key_fingerprint
}

resource "hcloud_server" "main" {
  for_each = {
    for vm in local.hcloud_vms : "${vm.id}" => vm
  }
  name        = "${var.ethereum_network}-${each.value.name}"
  image       = each.value.image
  server_type = each.value.server_type
  location    = each.value.location
  ssh_keys    = each.value.ssh_keys
  backups     = each.value.backups
  labels      = { for label in each.value.labels : split(":", label)[0] => split(":", label)[1] }
}

resource "hcloud_server_network" "main" {
  for_each = {
    for vm in local.hcloud_vms : "${vm.id}" => vm
  }
  server_id  = hcloud_server.main[each.key].id
  network_id = hcloud_network.main[each.value.location].id

}

////////////////////////////////////////////////////////////////////////////////////////
//                                   DNS NAMES
////////////////////////////////////////////////////////////////////////////////////////

data "cloudflare_zone" "default" {
  name = "ethpandaops.io"
}

resource "cloudflare_record" "server_record" {
  for_each = {
    for vm in local.hcloud_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "${each.value.name}.${var.ethereum_network}"
  type    = "A"
  value   = hcloud_server.main[each.value.id].ipv4_address
  proxied = false
  ttl     = 120
}

resource "cloudflare_record" "server_record_rpc" {
  for_each = {
    for vm in local.hcloud_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "rpc.${each.value.name}.${var.ethereum_network}"
  type    = "A"
  value   = hcloud_server.main[each.value.id].ipv4_address
  proxied = false
  ttl     = 120
}

resource "cloudflare_record" "server_record_beacon" {
  for_each = {
    for vm in local.hcloud_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "bn.${each.value.name}.${var.ethereum_network}"
  type    = "A"
  value   = hcloud_server.main[each.value.id].ipv4_address
  proxied = false
  ttl     = 120
}

////////////////////////////////////////////////////////////////////////////////////////
//                          GENERATED FILES AND OUTPUTS
////////////////////////////////////////////////////////////////////////////////////////

resource "local_file" "ansible_inventory" {
  depends_on = [hcloud_server.main]
  content = templatefile("../ansible_inventory.tmpl",
    {
      ethereum_network_name = "${var.ethereum_network}"
      groups = merge(
        { for group in local.hetzner_vm_groups : "${group.group_name}" => true... },
      )
      hosts = merge(
        {
          for key, server in hcloud_server.main : "${key}" => {
            ip              = server.ipv4_address
            group           = server.labels.group_name
            validator_start = server.labels.val_start
            validator_end   = server.labels.val_end
            tags            = server.labels
            hostname        = split(".", key)[0]
            cloud           = "hetzner"
            region          = server.datacenter
          }
        }
      )
    }
  )
  filename = "../../../ansible/inventories/devnet-12/hetzner_inventory.ini"
}

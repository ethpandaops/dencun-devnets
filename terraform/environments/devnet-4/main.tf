////////////////////////////////////////////////////////////////////////////////////////
//                            TERRAFORM PROVIDERS & BACKEND
////////////////////////////////////////////////////////////////////////////////////////
terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    endpoint                    = "https://fra1.digitaloceanspaces.com"
    region                      = "us-east-1"
    bucket                      = "merge-testnets"
    key                         = "infrastructure/4844-devnet-4/terraform.tfstate"
  }
}

provider "cloudflare" {}

////////////////////////////////////////////////////////////////////////////////////////
//                                        VARIABLES
////////////////////////////////////////////////////////////////////////////////////////
variable "ethereum_network" {
  type = string
  default = "4844-devnet-4"
}

variable "digitalocean_project_name" {
  type = string
  default = "4844 Testnets"
}

variable "digitalocean_ssh_key_name" {
  type = string
  default = "rafael"
}

variable "digitalocean_vpcs" {
  type = map
  default = {
    "ams3" = {
      ip_range = "10.48.45.0/24"
    }
  }
}

variable "digitalocean_vm_groups" {
  type = list
  default = [
    {
      id = "bootnode"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    // Lighthouse combos
    {
      id = "lighthouse-geth"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
        "2" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    {
      id = "lighthouse-nethermind"
      vms = {
        "1" = { size = "s-8vcpu-16gb-amd" }
      },
    },
    {
      id = "lighthouse-ethereumjs"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    {
      id = "lighthouse-erigon"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    // Prysm combos
    {
      id = "prysm-geth"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
        "2" = { size = "s-4vcpu-8gb-amd" }
        "3" = { size = "s-4vcpu-8gb-amd" }
        "4" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    {
      id = "prysm-nethermind"
      vms = {
        "1" = { size = "s-8vcpu-16gb-amd" }
      },
    },
    {
      id = "prysm-ethereumjs"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    {
      id = "prysm-erigon"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      },
    },
    // Lodestar combos
    {
      id = "lodestar-geth"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    {
      id = "lodestar-nethermind"
      vms = {
        "1" = { size = "s-8vcpu-16gb-amd" }
      }
    },
    {
      id = "lodestar-ethereumjs"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    {
      id = "lodestar-erigon"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    // Teku combos
    {
      id = "teku-geth"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    {
      id = "teku-nethermind"
      vms = {
        "1" = { size = "s-8vcpu-16gb-amd" }
      }
    },
    {
      id = "teku-ethereumjs"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
    {
      id = "teku-erigon"
      vms = {
        "1" = { size = "s-4vcpu-8gb-amd" }
      }
    },
  ]
}

////////////////////////////////////////////////////////////////////////////////////////
//                                        LOCALS
////////////////////////////////////////////////////////////////////////////////////////


locals {
  digitalocean_default_region = "ams3"
  digitalocean_default_size   = "s-1vcpu-2gb-amd"
  digitalocean_default_image  = "debian-11-x64"
  digitalocean_global_tags = [
    "Owner:Devops",
    "EthNetwork:${var.ethereum_network}"
  ]

  # flatten vm_groups so that we can use it with for_each()
  digitalocean_vms = flatten([
    for group in var.digitalocean_vm_groups : [
      for vm_key, vm in group.vms : {
        id        = "${group.id}.${vm_key}"
        group_key = group.id
        vm_key    = vm_key

        name        = try(vm.name, "${group.id}-${vm_key}")
        ssh_keys    = try(vm.ssh_keys, [data.digitalocean_ssh_key.main.fingerprint])
        region      = try(vm.region, try(group.region, local.digitalocean_default_region))
        image       = try(vm.image, local.digitalocean_default_image)
        size        = try(vm.size, local.digitalocean_default_size)
        resize_disk = try(vm.resize_disk, true)
        monitoring  = try(vm.monitoring, true)
        backups     = try(vm.backups, false)
        ipv6        = try(vm.ipv6, false)
        vpc_uuid    = try(vm.vpc_uuid, try(
          digitalocean_vpc.main[vm.region].id,
          digitalocean_vpc.main[try(group.region, local.digitalocean_default_region)].id
        ))

        tags = concat(local.digitalocean_global_tags, try(split(",", group.tags),[]), try(split(",",vm.tags),[]))
      }
    ]
  ])

}

////////////////////////////////////////////////////////////////////////////////////////
//                                  DIGITALOCEAN RESOURCES
////////////////////////////////////////////////////////////////////////////////////////
data "digitalocean_project" "main" {
  name = var.digitalocean_project_name
}

data "digitalocean_ssh_key" "main" {
  name = var.digitalocean_ssh_key_name
}

resource "digitalocean_vpc" "main" {
  for_each = var.digitalocean_vpcs
  name     = try(each.value.name, "${var.ethereum_network}-${each.key}")
  region   = each.key
  ip_range = each.value.ip_range
}

resource "digitalocean_droplet" "main" {
  for_each = {
    for vm in local.digitalocean_vms : "${vm.id}" => vm
  }
  name        = each.value.name
  region      = each.value.region
  ssh_keys    = each.value.ssh_keys
  image       = each.value.image
  size        = each.value.size
  resize_disk = each.value.resize_disk
  monitoring  = each.value.monitoring
  backups     = each.value.backups
  ipv6        = each.value.ipv6
  vpc_uuid    = each.value.vpc_uuid
  tags        = each.value.tags
}

resource "digitalocean_project_resources" "droplets" {
  for_each = digitalocean_droplet.main
  project = data.digitalocean_project.main.id
  resources = [each.value.urn]
}

resource "digitalocean_firewall" "main" {
  name        = "${var.ethereum_network}-nodes"
  // Tags are used to select which droplets should
  // be assigned to this firewall.
  tags        = [
    "EthNetwork:${var.ethereum_network}"
  ]

  // SSH
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Nginx / Web
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Consensus layer p2p port
  inbound_rule {
    protocol         = "tcp"
    port_range       = "9000-9001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "udp"
    port_range       = "9000-9001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Execution layer p2p Port
  inbound_rule {
    protocol         = "tcp"
    port_range       = "30303"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "udp"
    port_range       = "30303"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // Allow all outbound traffic
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

////////////////////////////////////////////////////////////////////////////////////////
//                                   DNS NAMES
////////////////////////////////////////////////////////////////////////////////////////

data "cloudflare_zone" "default" {
  name = "ethpandaops.io"
}

resource "cloudflare_record" "server_record" {
  for_each = {
    for vm in local.digitalocean_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "${each.value.name}.server.${var.ethereum_network}"
  type    = "A"
  value   = "${digitalocean_droplet.main[each.value.id].ipv4_address}"
  proxied = false
  ttl     = 120
}

resource "cloudflare_record" "server_record_rpc" {
  for_each = {
    for vm in local.digitalocean_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "rpc.${each.value.name}.server.${var.ethereum_network}"
  type    = "A"
  value   = "${digitalocean_droplet.main[each.value.id].ipv4_address}"
  proxied = false
  ttl     = 120
}

resource "cloudflare_record" "server_record_beacon" {
  for_each = {
    for vm in local.digitalocean_vms : "${vm.id}" => vm
  }
  zone_id = data.cloudflare_zone.default.id
  name    = "beacon.${each.value.name}.server.${var.ethereum_network}"
  type    = "A"
  value   = "${digitalocean_droplet.main[each.value.id].ipv4_address}"
  proxied = false
  ttl     = 120
}

////////////////////////////////////////////////////////////////////////////////////////
//                          GENERATED FILES AND OUTPUTS
////////////////////////////////////////////////////////////////////////////////////////

resource "local_file" "ansible_inventory" {
  content = templatefile("ansible_inventory.tmpl",
    {
      ethereum_network_name = "${var.ethereum_network}"
      groups = merge(
        { for group in var.digitalocean_vm_groups: "${group.id}" => true },
      )
      hosts  = merge(
        {
          for key, server in digitalocean_droplet.main: "do.${key}" => {
            ip = "${server.ipv4_address}"
            group = split(".", key)[0]
            hostname = "${split(".", key)[0]}-${split(".", key)[1]}"
            cloud  = "digitalocean"
            region = "${server.region}"
          }
        }
      )
    }
  )
  filename = "inventory.ini"
}

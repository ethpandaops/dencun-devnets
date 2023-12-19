# mev-relay
variable "mev_relay" {
  default = {
    name            = "mev-relay"
    count           = 1
    validator_start = 0
    validator_end   = 0
  }
}

# Bootnode
variable "bootnode" {
  default = {
    name            = "bootnode"
    count           = 5
    validator_start = 0
    validator_end   = 0
    location        = "fra1"
  }
}

# Lighthouse
variable "lighthouse_geth" {
  default = {
    name            = "lighthouse-geth"
    count           = 95
    validator_start = 0
    validator_end   = 9500
    location        = "fra1"
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 16
    validator_start = 9500
    validator_end   = 11100
    location        = "nyc1"
  }
}

variable "lighthouse_besu" {
  default = {
    name            = "lighthouse-besu"
    count           = 3
    validator_start = 11100
    validator_end   = 11700
    location        = "blr1"
  }
}

variable "lighthouse_erigon" {
  default = {
    name            = "lighthouse-erigon"
    count           = 1
    validator_start = 0
    validator_end   = 0
    location        = "sfo3"
    size            = "so-8vcpu-64gb"
  }
}

variable "lighthouse_ethereumjs" {
  default = {
    name            = "lighthouse-ethereumjs"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Prysm
variable "prysm_geth" {
  default = {
    name            = "prysm-geth"
    count           = 95
    validator_start = 11700
    validator_end   = 21200
    location        = "syd1"
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 16
    validator_start = 21200
    validator_end   = 22800
    location        = "nyc1"
  }
}

variable "prysm_besu" {
  default = {
    name            = "prysm-besu"
    count           = 3
    validator_start = 22800
    validator_end   = 23400
    location        = "fra1"
  }
}

variable "prysm_erigon" {
  default = {
    name            = "prysm-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "blr1"
    size            = "so-8vcpu-64gb"
  }
}

variable "prysm_ethereumjs" {
  default = {
    name            = "prysm-ethereumjs"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Lodestar
variable "lodestar_geth" {
  default = {
    name            = "lodestar-geth"
    count           = 3
    validator_start = 23400
    validator_end   = 23700
    location        = "fra1"
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 3
    validator_start = 23700
    validator_end   = 24000
    location        = "blr1"
  }
}

variable "lodestar_besu" {
  default = {
    name            = "lodestar-besu"
    count           = 3
    validator_start = 24000
    validator_end   = 24600
    location        = "sfo3"
  }
}

variable "lodestar_erigon" {
  default = {
    name            = "lodestar-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "syd1"
    size            = "so-8vcpu-64gb"
  }
}

variable "lodestar_ethereumjs" {
  default = {
    name            = "lodestar-ethereumjs"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "nyc1"
  }
}

# Teku
variable "teku_geth" {
  default = {
    name            = "teku-geth"
    count           = 15
    validator_start = 24600
    validator_end   = 26100
    location        = "fra1"
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 6
    validator_start = 26100
    validator_end   = 26700
    location        = "blr1"
  }
}

variable "teku_besu" {
  default = {
    name            = "teku-besu"
    count           = 3
    validator_start = 26700
    validator_end   = 27300
    location        = "sfo3"
  }
}

variable "teku_erigon" {
  default = {
    name            = "teku-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "syd1"
    size            = "so-8vcpu-64gb"
  }
}

variable "teku_ethereumjs" {
  default = {
    name            = "teku-ethereumjs"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Nimbus
variable "nimbus_geth" {
  default = {
    name            = "nimbus-geth"
    count           = 3
    validator_start = 27300
    validator_end   = 27600
    location        = "nyc1"
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 3
    validator_start = 27600
    validator_end   = 27900
    location        = "fra1"
  }
}

variable "nimbus_besu" {
  default = {
    name            = "nimbus-besu"
    count           = 3
    validator_start = 27900
    validator_end   = 28500
    location        = "blr1"
  }
}

variable "nimbus_erigon" {
  default = {
    name            = "nimbus-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "sfo3"
    size            = "so-8vcpu-64gb"
  }
}

variable "nimbus_ethereumjs" {
  default = {
    name            = "nimbus-ethereumjs"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Reth
variable "lighthouse_reth" {
  default = {
    name            = "lighthouse-reth"
    count           = 3
    validator_start = 28500
    validator_end   = 28800
    location        = "syd1"
    size            = "so-8vcpu-64gb"
  }
}

variable "prysm_reth" {
  default = {
    name            = "prysm-reth"
    count           = 3
    validator_start = 28800
    validator_end   = 29100
    location        = "nyc1"
    size            = "so-8vcpu-64gb"
  }
}

variable "lodestar_reth" {
  default = {
    name            = "lodestar-reth"
    count           = 3
    validator_start = 29100
    validator_end   = 29400
    location        = "fra1"
    size            = "so-8vcpu-64gb"
  }
}

variable "teku_reth" {
  default = {
    name            = "teku-reth"
    count           = 3
    validator_start = 29400
    validator_end   = 29700
    location        = "blr1"
    size            = "so-8vcpu-64gb"
  }
}

variable "nimbus_reth" {
  default = {
    name            = "nimbus-reth"
    count           = 3
    validator_start = 29700
    validator_end   = 30000
    location        = "sfo3"
    size            = "so-8vcpu-64gb"
  }
}

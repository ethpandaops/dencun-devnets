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
    count           = 1
    validator_start = 0
    validator_end   = 0
    location        = "fra1"
  }
}

# Lighthouse
variable "lighthouse_geth" {
  default = {
    name            = "lighthouse-geth"
    count           = 1
    validator_start = 0
    validator_end   = 500
    location        = "fra1"
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 1
    validator_start = 500
    validator_end   = 1000
    location        = "nyc1"
  }
}

variable "lighthouse_besu" {
  default = {
    name            = "lighthouse-besu"
    count           = 1
    validator_start = 1000
    validator_end   = 1500
    location        = "blr1"
  }
}

variable "lighthouse_erigon" {
  default = {
    name            = "lighthouse-erigon"
    count           = 1
    validator_start = 10000
    validator_end   = 10100
    location        = "sfo3"
    size            = "so1_5-16vcpu-128gb"
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
    count           = 1
    validator_start = 1500
    validator_end   = 2000
    location        = "syd1"
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 1
    validator_start = 2000
    validator_end   = 2500
    location        = "nyc1"
  }
}

variable "prysm_besu" {
  default = {
    name            = "prysm-besu"
    count           = 1
    validator_start = 2500
    validator_end   = 3000
    location        = "fra1"
  }
}

variable "prysm_erigon" {
  default = {
    name            = "prysm-erigon"
    count           = 1
    validator_start = 10100
    validator_end   = 10200
    location        = "blr1"
    size            = "so1_5-16vcpu-128gb"
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
    count           = 1
    validator_start = 3000
    validator_end   = 3500
    location        = "fra1"
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 1
    validator_start = 3500
    validator_end   = 4000
    location        = "blr1"
  }
}

variable "lodestar_besu" {
  default = {
    name            = "lodestar-besu"
    count           = 1
    validator_start = 4000
    validator_end   = 4500
    location        = "sfo3"
  }
}

variable "lodestar_erigon" {
  default = {
    name            = "lodestar-erigon"
    count           = 1
    validator_start = 10200
    validator_end   = 10300
    location        = "syd1"
    size            = "so1_5-16vcpu-128gb"
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
    count           = 1
    validator_start = 4500
    validator_end   = 5000
    location        = "fra1"
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 1
    validator_start = 5000
    validator_end   = 5500
    location        = "blr1"
  }
}

variable "teku_besu" {
  default = {
    name            = "teku-besu"
    count           = 1
    validator_start = 5500
    validator_end   = 6000
    location        = "sfo3"
  }
}

variable "teku_erigon" {
  default = {
    name            = "teku-erigon"
    count           = 1
    validator_start = 10300
    validator_end   = 10400
    location        = "syd1"
    size            = "so1_5-16vcpu-128gb"
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
    count           = 1
    validator_start = 6000
    validator_end   = 6500
    location        = "nyc1"
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 1
    validator_start = 6500
    validator_end   = 7000
    location        = "fra1"
  }
}

variable "nimbus_besu" {
  default = {
    name            = "nimbus-besu"
    count           = 1
    validator_start = 7000
    validator_end   = 7500
    location        = "blr1"
  }
}

variable "nimbus_erigon" {
  default = {
    name            = "nimbus-erigon"
    count           = 1
    validator_start = 10400
    validator_end   = 10500
    location        = "sfo3"
    size            = "so1_5-16vcpu-128gb"
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
    count           = 1
    validator_start = 7500
    validator_end   = 8000
    location        = "syd1"
    size            = "so1_5-16vcpu-128gb"
  }
}

variable "prysm_reth" {
  default = {
    name            = "prysm-reth"
    count           = 1
    validator_start = 8000
    validator_end   = 8500
    location        = "nyc1"
    size            = "so1_5-16vcpu-128gb"
  }
}

variable "lodestar_reth" {
  default = {
    name            = "lodestar-reth"
    count           = 1
    validator_start = 8500
    validator_end   = 9000
    location        = "fra1"
    size            = "so1_5-16vcpu-128gb"
  }
}

variable "teku_reth" {
  default = {
    name            = "teku-reth"
    count           = 1
    validator_start = 9000
    validator_end   = 9500
    location        = "blr1"
    size            = "so1_5-16vcpu-128gb"
  }
}

variable "nimbus_reth" {
  default = {
    name            = "nimbus-reth"
    count           = 1
    validator_start = 9500
    validator_end   = 10000
    location        = "sfo3"
    size            = "so1_5-16vcpu-128gb"
  }
}

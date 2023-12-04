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
    size            = "s-4vcpu-16gb-320gb-intel"
  }
}

# Lighthouse
variable "lighthouse_geth" {
  default = {
    name            = "lighthouse-geth"
    count           = 1
    validator_start = 0
    validator_end   = 100
    location        = "fra1"
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 1
    validator_start = 100
    validator_end   = 200
    location        = "nyc1"
  }
}

variable "lighthouse_besu" {
  default = {
    name            = "lighthouse-besu"
    count           = 1
    validator_start = 200
    validator_end   = 225
    location        = "blr1"
  }
}

variable "lighthouse_erigon" {
  default = {
    name            = "lighthouse-erigon"
    count           = 1
    validator_start = 225
    validator_end   = 250
    location        = "sfo3"
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
    count           = 0
    validator_start = 250
    validator_end   = 360
    location        = "syd1"
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 0
    validator_start = 360
    validator_end   = 460
    location        = "nyc1"
  }
}

variable "prysm_besu" {
  default = {
    name            = "prysm-besu"
    count           = 0
    validator_start = 460
    validator_end   = 485
    location        = "fra1"
  }
}

variable "prysm_erigon" {
  default = {
    name            = "prysm-erigon"
    count           = 0
    validator_start = 485
    validator_end   = 510
    location        = "blr1"
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
    validator_start = 510
    validator_end   = 620
    location        = "fra1"
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 1
    validator_start = 620
    validator_end   = 720
    location        = "blr1"
  }
}

variable "lodestar_besu" {
  default = {
    name            = "lodestar-besu"
    count           = 1
    validator_start = 720
    validator_end   = 745
    location        = "sfo3"
  }
}

variable "lodestar_erigon" {
  default = {
    name            = "lodestar-erigon"
    count           = 1
    validator_start = 745
    validator_end   = 770
    location        = "syd1"
  }
}

variable "lodestar_ethereumjs" {
  default = {
    name            = "lodestar-ethereumjs"
    count           = 1
    validator_start = 770
    validator_end   = 780
    location        = "nyc1"
  }
}

# Teku
variable "teku_geth" {
  default = {
    name            = "teku-geth"
    count           = 1
    validator_start = 780
    validator_end   = 880
    location        = "fra1"
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 1
    validator_start = 880
    validator_end   = 980
    location        = "blr1"
  }
}

variable "teku_besu" {
  default = {
    name            = "teku-besu"
    count           = 1
    validator_start = 980
    validator_end   = 1005
    location        = "sfo3"
  }
}

variable "teku_erigon" {
  default = {
    name            = "teku-erigon"
    count           = 1
    validator_start = 1005
    validator_end   = 1030
    location        = "syd1"
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
    validator_start = 1030
    validator_end   = 1140
    location        = "nyc1"
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 1
    validator_start = 1140
    validator_end   = 1240
    location        = "fra1"
  }
}

variable "nimbus_besu" {
  default = {
    name            = "nimbus-besu"
    count           = 1
    validator_start = 1240
    validator_end   = 1265
    location        = "blr1"
  }
}

variable "nimbus_erigon" {
  default = {
    name            = "nimbus-erigon"
    count           = 1
    validator_start = 1265
    validator_end   = 1290
    location        = "sfo3"
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
    validator_start = 1290
    validator_end   = 1450
    location        = "syd1"
  }
}

variable "prysm_reth" {
  default = {
    name            = "prysm-reth"
    count           = 0
    validator_start = 0
    validator_end   = 0
    location        = "nyc1"
  }
}

variable "lodestar_reth" {
  default = {
    name            = "lodestar-reth"
    count           = 1
    validator_start = 1450
    validator_end   = 1600
    location        = "fra1"
  }
}

variable "teku_reth" {
  default = {
    name            = "teku-reth"
    count           = 1
    validator_start = 1600
    validator_end   = 1700
    location        = "blr1"
  }
}

variable "nimbus_reth" {
  default = {
    name            = "nimbus-reth"
    count           = 1
    validator_start = 1700
    validator_end   = 1800
    location        = "sfo3"
  }
}

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
    count           = 2
    validator_start = 0
    validator_end   = 0
  }
}

# Lighthouse
variable "lighthouse_geth" {
  default = {
    name            = "lighthouse-geth"
    count           = 5
    validator_start = 0
    validator_end   = 25000
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 5
    validator_start = 25000
    validator_end   = 50000
  }
}

variable "lighthouse_besu" {
  default = {
    name            = "lighthouse-besu"
    count           = 2
    validator_start = 225000
    validator_end   = 235000
  }
}

variable "lighthouse_erigon" {
  default = {
    name            = "lighthouse-erigon"
    count           = 2
    validator_start = 235000
    validator_end   = 245000
  }
}

variable "lighthouse_ethereumjs" {
  default = {
    name            = "lighthouse-ethereumjs"
    count           = 1
    validator_start = 325000
    validator_end   = 326000
  }
}

# Prysm
variable "prysm_geth" {
  default = {
    name            = "prysm-geth"
    count           = 5
    validator_start = 50000
    validator_end   = 75000
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 5
    validator_start = 75000
    validator_end   = 100000
  }
}

variable "prysm_besu" {
  default = {
    name            = "prysm-besu"
    count           = 2
    validator_start = 245000
    validator_end   = 255000
  }
}

variable "prysm_erigon" {
  default = {
    name            = "prysm-erigon"
    count           = 2
    validator_start = 255000
    validator_end   = 265000
  }
}

variable "prysm_ethereumjs" {
  default = {
    name            = "prysm-ethereumjs"
    count           = 1
    validator_start = 326000
    validator_end   = 327000
  }
}

# Lodestar
variable "lodestar_geth" {
  default = {
    name            = "lodestar-geth"
    count           = 5
    validator_start = 100000
    validator_end   = 125000
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 5
    validator_start = 335000
    validator_end   = 360000
  }
}

variable "lodestar_besu" {
  default = {
    name            = "lodestar-besu"
    count           = 2
    validator_start = 265000
    validator_end   = 275000
  }
}

variable "lodestar_erigon" {
  default = {
    name            = "lodestar-erigon"
    count           = 2
    validator_start = 275000
    validator_end   = 285000
  }
}

variable "lodestar_ethereumjs" {
  default = {
    name            = "lodestar-ethereumjs"
    count           = 1
    validator_start = 327000
    validator_end   = 328000
  }
}

# Teku
variable "teku_geth" {
  default = {
    name            = "teku-geth"
    count           = 5
    validator_start = 125000
    validator_end   = 150000
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 5
    validator_start = 150000
    validator_end   = 175000
  }
}

variable "teku_besu" {
  default = {
    name            = "teku-besu"
    count           = 2
    validator_start = 285000
    validator_end   = 295000
  }
}

variable "teku_erigon" {
  default = {
    name            = "teku-erigon"
    count           = 2
    validator_start = 295000
    validator_end   = 305000
  }
}

variable "teku_ethereumjs" {
  default = {
    name            = "teku-ethereumjs"
    count           = 1
    validator_start = 328000
    validator_end   = 329000
  }
}

# Nimbus
variable "nimbus_geth" {
  default = {
    name            = "nimbus-geth"
    count           = 5
    validator_start = 175000
    validator_end   = 200000
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 5
    validator_start = 200000
    validator_end   = 225000
  }
}

variable "nimbus_besu" {
  default = {
    name            = "nimbus-besu"
    count           = 2
    validator_start = 305000
    validator_end   = 315000
  }
}

variable "nimbus_erigon" {
  default = {
    name            = "nimbus-erigon"
    count           = 2
    validator_start = 315000
    validator_end   = 325000
  }
}

variable "nimbus_ethereumjs" {
  default = {
    name            = "nimbus-ethereumjs"
    count           = 1
    validator_start = 329000
    validator_end   = 330000
  }
}

# Reth
variable "lighthouse_reth" {
  default = {
    name            = "lighthouse-reth"
    count           = 1
    validator_start = 330000
    validator_end   = 331000
  }
}

variable "prysm_reth" {
  default = {
    name            = "prysm-reth"
    count           = 1
    validator_start = 331000
    validator_end   = 332000
  }
}

variable "lodestar_reth" {
  default = {
    name            = "lodestar-reth"
    count           = 1
    validator_start = 332000
    validator_end   = 333000
  }
}

variable "teku_reth" {
  default = {
    name            = "teku-reth"
    count           = 1
    validator_start = 333000
    validator_end   = 334000
  }
}

variable "nimbus_reth" {
  default = {
    name            = "nimbus-reth"
    count           = 1
    validator_start = 334000
    validator_end   = 335000
  }
}

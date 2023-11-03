# Bootnode
variable "bootnode" {
  default = {
    name            = "bootnode"
    count           = 1
    validator_start = 0
    validator_end   = 0
  }
}

# Lighthouse
variable "lighthouse_geth" {
  default = {
    name            = "lighthouse-geth"
    count           = 1
    validator_start = 0
    validator_end   = 100
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 1
    validator_start = 100
    validator_end   = 200
  }
}

variable "lighthouse_besu" {
  default = {
    name            = "lighthouse-besu"
    count           = 1
    validator_start = 200
    validator_end   = 300
  }
}

variable "lighthouse_erigon" {
  default = {
    name            = "lighthouse-erigon"
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
    validator_start = 300
    validator_end   = 500
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 1
    validator_start = 500
    validator_end   = 600
  }
}

variable "prysm_besu" {
  default = {
    name            = "prysm-besu"
    count           = 1
    validator_start = 600
    validator_end   = 700
  }
}

variable "prysm_erigon" {
  default = {
    name            = "prysm-erigon"
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
    validator_start = 700
    validator_end   = 900
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 1
    validator_start = 900
    validator_end   = 1000
  }
}

variable "lodestar_besu" {
  default = {
    name            = "lodestar-besu"
    count           = 1
    validator_start = 1000
    validator_end   = 1100
  }
}

variable "lodestar_erigon" {
  default = {
    name            = "lodestar-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Teku
variable "teku_geth" {
  default = {
    name            = "teku-geth"
    count           = 1
    validator_start = 1100
    validator_end   = 1300
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 1
    validator_start = 1300
    validator_end   = 1400
  }
}

variable "teku_besu" {
  default = {
    name            = "teku-besu"
    count           = 1
    validator_start = 1400
    validator_end   = 1500
  }
}

variable "teku_erigon" {
  default = {
    name            = "teku-erigon"
    count           = 1
    validator_start = 1500
    validator_end   = 1600
  }
}

# Nimbus
variable "nimbus_geth" {
  default = {
    name            = "nimbus-geth"
    count           = 1
    validator_start = 1600
    validator_end   = 1700
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 1
    validator_start = 1700
    validator_end   = 1800
  }
}

variable "nimbus_besu" {
  default = {
    name            = "nimbus-besu"
    count           = 1
    validator_start = 1800
    validator_end   = 2000
  }
}

variable "nimbus_erigon" {
  default = {
    name            = "nimbus-erigon"
    count           = 0
    validator_start = 0
    validator_end   = 0
  }
}

# Reth
variable "teku_reth" {
  default = {
    name            = "teku-reth"
    count           = 1
    validator_start = 2000
    validator_end   = 2100
  }
}


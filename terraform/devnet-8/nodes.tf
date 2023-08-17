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
    validator_end   = 10
  }
}

variable "lighthouse_nethermind" {
  default = {
    name            = "lighthouse-nethermind"
    count           = 1
    validator_start = 10
    validator_end   = 20
  }
}

# variable "lighthouse_besu" {
#   default = {
#     name            = "lighthouse-besu"
#     count           = 1
#     validator_start = 20
#     validator_end   = 24
#   }
# }

variable "lighthouse_ethereumjs" {
  default = {
    name            = "lighthouse-ethereumjs"
    count           = 1
    validator_start = 20
    validator_end   = 28
  }
}

# variable "lighthouse_erigon" {
#   default = {
#     name            = "lighthouse-erigon"
#     count           = 1
#     validator_start = 26
#     validator_end   = 28
#   }
# }

# Prysm
variable "prysm_geth" {
  default = {
    name            = "prysm-geth"
    count           = 1
    validator_start = 0
    validator_end   = 0
  }
}

variable "prysm_nethermind" {
  default = {
    name            = "prysm-nethermind"
    count           = 1
    validator_start = 0
    validator_end   = 0
  }
}

# variable "prysm_besu" {
#   default = {
#     name            = "prysm-besu"
#     count           = 1
#     validator_start = 48
#     validator_end   = 52
#   }
# }

variable "prysm_ethereumjs" {
  default = {
    name            = "prysm-ethereumjs"
    count           = 1
    validator_start = 0
    validator_end   = 0
  }
}

# variable "prysm_erigon" {
#   default = {
#     name            = "prysm-erigon"
#     count           = 1
#     validator_start = 54
#     validator_end   = 56
#   }
# }

# Lodestar
variable "lodestar_geth" {
  default = {
    name            = "lodestar-geth"
    count           = 1
    validator_start = 56
    validator_end   = 66
  }
}

variable "lodestar_nethermind" {
  default = {
    name            = "lodestar-nethermind"
    count           = 1
    validator_start = 66
    validator_end   = 76
  }
}

# variable "lodestar_besu" {
#   default = {
#     name            = "lodestar-besu"
#     count           = 1
#     validator_start = 76
#     validator_end   = 80
#   }
# }

variable "lodestar_ethereumjs" {
  default = {
    name            = "lodestar-ethereumjs"
    count           = 1
    validator_start = 76
    validator_end   = 84
  }
}

# variable "lodestar_erigon" {
#   default = {
#     name            = "lodestar-erigon"
#     count           = 1
#     validator_start = 82
#     validator_end   = 84
#   }
# }

# Teku
variable "teku_geth" {
  default = {
    name            = "teku-geth"
    count           = 1
    validator_start = 84
    validator_end   = 114
  }
}

variable "temp_teku_geth" {
  default = {
    name            = "temp-teku-geth"
    count           = 1
    validator_start = 28
    validator_end   = 56
  }
}

variable "teku_nethermind" {
  default = {
    name            = "teku-nethermind"
    count           = 1
    validator_start = 114
    validator_end   = 134
  }
}

# variable "teku_besu" {
#   default = {
#     name            = "teku-besu"
#     count           = 1
#     validator_start = 104
#     validator_end   = 108
#   }
#}

variable "teku_ethereumjs" {
  default = {
    name            = "teku-ethereumjs"
    count           = 1
    validator_start = 134
    validator_end   = 140
  }
}

# variable "teku_erigon" {
#   default = {
#     name            = "teku-erigon"
#     count           = 1
#     validator_start = 110
#     validator_end   = 112
#   }
# }


# Nimbus
variable "nimbus_geth" {
  default = {
    name            = "nimbus-geth"
    count           = 1
    validator_start = 140
    validator_end   = 142
  }
}

variable "nimbus_nethermind" {
  default = {
    name            = "nimbus-nethermind"
    count           = 1
    validator_start = 142
    validator_end   = 144
  }
}

# variable "nimbus_besu" {
#   default = {
#     name            = "nimbus-besu"
#     count           = 1
#     validator_start = 132
#     validator_end   = 136
#   }
# }

variable "nimbus_ethereumjs" {
  default = {
    name            = "nimbus-ethereumjs"
    count           = 1
    validator_start = 144
    validator_end   = 146
  }
}

# variable "nimbus_erigon" {
#   default = {
#     name            = "nimbus-erigon"
#     count           = 1
#     validator_start = 138
#     validator_end   = 140
#   }
# }

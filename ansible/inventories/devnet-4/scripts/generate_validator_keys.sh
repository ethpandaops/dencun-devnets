#!/bin/bash


if [ -z "$VALIDATORS_MNEMONIC_0" ]; then
  echo "missing mnemonic 0"
  exit 1
fi

if [ -z "$VALIDATORS_MNEMONIC_1" ]; then
  echo "missing mnemonic 1"
  exit 1
fi

OUTPUT_DIR=../files/validator_keys
PRYSM_WALLET_PASSWORD="prysm"

function prep_group {
  let group_base=$1
  validators_source_mnemonic="$2"
  let offset=$3
  let keys_to_create=$4
  naming_prefix="$5"
  validators_per_host=$6
  echo "Group base: $group_base"
  for (( i = 0; i < keys_to_create; i++ )); do
    let node_index=group_base+i
    let offset_i=offset+i
    let validators_source_min=offset_i*validators_per_host
    let validators_source_max=validators_source_min+validators_per_host

    echo "writing keystores for host $naming_prefix-$node_index: $validators_source_min - $validators_source_max"
    eth2-val-tools keystores \
    --insecure \
    --prysm-pass="$PRYSM_WALLET_PASSWORD" \
    --out-loc="$OUTPUT_DIR/$naming_prefix-$node_index" \
    --source-max="$validators_source_max" \
    --source-min="$validators_source_min" \
    --source-mnemonic="$validators_source_mnemonic"
  done
}

prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 4 "prysm-geth" 1500      # 6000
prep_group 1 "$VALIDATORS_MNEMONIC_0" 4 2 "lighthouse-geth" 1500 # 3000

prep_group 1 "$VALIDATORS_MNEMONIC_1" 0 1 "lodestar-geth" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 1 1 "lodestar-erigon" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 2 1 "lodestar-ethereumjs" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 3 1 "lodestar-nethermind" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 4 1 "lodestar-besu" 20

prep_group 1 "$VALIDATORS_MNEMONIC_1" 5 1 "prysm-erigon" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 6 1 "prysm-ethereumjs" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 7 1 "prysm-nethermind" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 8 1 "prysm-besu" 20

prep_group 1 "$VALIDATORS_MNEMONIC_1" 9 1 "lighthouse-erigon" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 10 1 "lighthouse-ethereumjs" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 11 1 "lighthouse-nethermind" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 12 1 "lighthouse-besu" 20

prep_group 1 "$VALIDATORS_MNEMONIC_1" 13 1 "nimbus-geth" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 14 1 "nimbus-erigon" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 15 1 "nimbus-ethereumjs" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 16 1 "nimbus-nethermind" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 17 1 "nimbus-besu" 20

prep_group 1 "$VALIDATORS_MNEMONIC_1" 18 1 "teku-geth" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 19 1 "teku-erigon" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 20 1 "teku-ethereumjs" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 21 1 "teku-nethermind" 20
prep_group 1 "$VALIDATORS_MNEMONIC_1" 22 1 "teku-besu" 20

echo "$PRYSM_WALLET_PASSWORD" > $OUTPUT_DIR/prysm_wallet_pass.txt

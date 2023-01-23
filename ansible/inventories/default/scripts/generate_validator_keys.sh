#!/bin/bash


if [ -z "$VALIDATORS_MNEMONIC_0" ]; then
  echo "missing mnemonic 0"
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

prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 1 "4844-devnet-default-teku-geth" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 1 1 "4844-devnet-default-lighthouse-geth" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 2 1 "4844-devnet-default-prysm-geth" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 1 "4844-devnet-default-lodestar-geth" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 4 1 "4844-devnet-default-teku-nethermind" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 5 1 "4844-devnet-default-lighthouse-nethermind" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 6 1 "4844-devnet-default-prysm-nethermind" 100
prep_group 1 "$VALIDATORS_MNEMONIC_0" 7 1 "4844-devnet-default-lodestar-nethermind" 100

echo "$PRYSM_WALLET_PASSWORD" > $OUTPUT_DIR/prysm_wallet_pass.txt

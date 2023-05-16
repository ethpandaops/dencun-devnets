#!/bin/bash


if [ -z "$VALIDATORS_MNEMONIC_0" ]; then
  echo "missing mnemonic 0"
  exit 1
fi


OUTPUT_DIR=../files/validator_keys
mkdir -p $OUTPUT_DIR
PRYSM_WALLET_PASSWORD="prysm"
echo $PRYSM_WALLET_PASSWORD > $OUTPUT_DIR/prysm_wallet_pass.txt
function prep_group {
  let group_base=$1
  validators_source_mnemonic="$2"
  let offset=$3
  let keys_to_create=$4
  naming_prefix="$5"
  validators_per_host=$6
  el_address=$(cat ../group_vars/all/all.yaml| yq .ethereum_node_cl_validator_fee_recipient)
  genesis_root=$(cat ../../../../network-configs/devnet-5/parsedBeaconState.json| jq -r .genesis_validators_root)
  genesis_version=$(cat ../../../../network-configs/devnet-5/config.yaml| yq .GENESIS_FORK_VERSION)
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
    eth2-val-tools bls-address-change \
    --withdrawals-mnemonic="$validators_source_mnemonic" \
    --execution-address="$el_address" \
    --source-min="$validators_source_min" \
    --source-max="$validators_source_max" \
    --genesis-validators-root=$genesis_root \
    --fork-version="$genesis_version" \
    --as-json-list=true > "$OUTPUT_DIR/$naming_prefix-$node_index/change_operations.json"
  done
}

prep_group 1 "$VALIDATORS_MNEMONIC_0" 0 1 "lodestar-ethereumjs" 100 # 0 - 99
prep_group 1 "$VALIDATORS_MNEMONIC_0" 1 1 "lodestar-nethermind" 100 # 100 - 199
prep_group 1 "$VALIDATORS_MNEMONIC_0" 2 1 "lodestar-erigon" 100 # 200 - 299
prep_group 1 "$VALIDATORS_MNEMONIC_0" 3 1 "lighthouse-ethereumjs" 100 # 300 - 399
prep_group 1 "$VALIDATORS_MNEMONIC_0" 4 1 "lighthouse-nethermind" 100 # 400 - 499
prep_group 1 "$VALIDATORS_MNEMONIC_0" 5 1 "lighthouse-erigon" 100 # 500 - 599
prep_group 1 "$VALIDATORS_MNEMONIC_0" 6 1 "prysm-ethereumjs" 100 # 600 - 699
prep_group 1 "$VALIDATORS_MNEMONIC_0" 7 1 "prysm-nethermind" 100 # 700 - 799
prep_group 1 "$VALIDATORS_MNEMONIC_0" 8 1 "prysm-erigon" 100 # 800 - 899
prep_group 1 "$VALIDATORS_MNEMONIC_0" 9 1 "extra" 100 # 900 - 999 also used on lodestar-ethereumjs for now

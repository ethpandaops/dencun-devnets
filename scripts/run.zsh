#!/bin/zsh
node="lighthouse-nethermind-1"
network="devnet-7"
domain="ethpandaops.io"
prefix="4844"
sops_name=$(sops --decrypt ../ansible/inventories/$network/group_vars/all/all.sops.yaml | yq -r '.secret_nginx_shared_basic_auth.name')
sops_password=$(sops --decrypt ../ansible/inventories/$network/group_vars/all/all.sops.yaml | yq -r '.secret_nginx_shared_basic_auth.password')
sops_mnemonic=$(sops --decrypt ../ansible/inventories/$network/group_vars/all/all.sops.yaml | yq -r '.secret_genesis_mnemonic')

# Helper function to display available options
print_usage() {
  echo "Usage:"
  echo "  ./run.zsh [command]"
  echo
  echo "Available commands:"
  echo "  genesis                           Get the genesis block"
  echo "  validators                        Get the validator ranges"
  echo "  latest_root                       Get the latest root"
  echo "  latest_slot                       Get the latest slot"
  echo "  latest_slot_verbose               Get the latest slot with verbose output"
  echo "  latest_block                      Get the latest block"
  echo "  finalized_epoch                   Get the finalized epoch"
  echo "  finalized_slot                    Get the finalized slot"
  echo "  finalized_slot_verbose            Get the finalized slot with verbose output"
  echo "  finalized_slot_exec_payload       Get the finalized slot execution payload"
  echo "  epoch_summary n                   Get the epoch summary for epoch n [default current - 1 epoch]"
  echo "  get_slot_for_blob txhash          Get the slot for a given blob given txhash, or send blob now"
  echo "  get_slot_for_blob_verbose txhash  Get the slot for a given blob with verbose output given txhash, or send blob now"
  echo "  whose_validator_for_slot n        Get the validator for a given slot "n" - mandatory argument"
  echo "  get_enrs                          Get the ENRs of the network"
  echo "  get_enodes                        Get the enodes of the network"
  echo "  get_peerid                        Get the peerid of the network"
  echo "  get_rpc                           Get the rpc of the network"
  echo "  get_beacon                        Get the beacon of the network"
  echo "  get_inventory                     Get the inventory of the network"
  echo "  fork_choice                       Get the fork choice of the network"
  echo "  send_blob n                       Send "n" number of blob(s) to the network [default 1]"
  echo "  deposit s e                       Deposit to the network from validator index start to end - mandatory argument"
  echo "  help                              Print this help message"
  echo
}

# Store the command in an array
command=("$@")

# Check if no command are provided
if [[ $# -eq 0 ]]; then
  echo "Please provide at least one argument."
  print_usage
  exit 1
fi

# Loop through each argument
for arg in "${command[@]}"; do
  case $arg in
    "genesis")
      # Get the genesis block of the network
      genesis=$(curl -s https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain/eth/v1/beacon/genesis | jq .data)
      echo "Genesis Block: $genesis"
      ;;
    "validators")
      # Get the validators of the network
      validators=$(curl -s https://bootnode-1.srv.$prefix-$network.$domain/meta/api/v1/validator-ranges.json | jq .ranges)
      echo "Validator ranges: $validators"
      ;;
    "latest_root")
      # Get the latest root of the network
      latest_root=$(curl -s https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain/eth/v1/beacon/states/head/root | jq .data.root)
      echo "Latest Root: $latest_root"
      ;;
    "latest_slot")
      # Get the latest slot of the network
      latest_slot=$(curl -s https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain/eth/v1/beacon/headers/head | jq .)
      echo "Latest Slot: $latest_slot"\
      ;;
    "latest_slot_verbose")
      # Get the latest slot of the network
      latest_slot=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --verbose )
      echo "Latest Slot: $latest_slot"
      ;;
    "latest_block")
      # Get the latest block of the network
      latest_block=$(curl -s --data-raw '{"jsonrpc":"2.0","method":"eth_getBlockByNumber", "params":["latest"], "id":0}' https://$sops_name:$sops_password@rpc.$prefix-$network.$domain | jq .)
      echo "Latest Block: $latest_block"
      ;;
    "finalized_epoch")
      # Get the finalized slot of the network
      finalized_epoch=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain chain status --verbose | awk '/Finalized epoch:/{print $NF}')
      echo "Finalized epoch: $finalized_epoch"
      ;;
    "finalized_slot")
      # Get the finalized slot of the network
      finalized_epoch=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain chain status --verbose | awk '/Finalized epoch:/{print $NF}')
      finalized_slotnum=$((finalized_epoch * 32))
      echo "Finalized slot: $finalized_slotnum"
      ;;
    "finalized_slot_verbose")
      # Get the finalized slot of the network
      finalized_epoch=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain chain status --verbose | awk '/Finalized epoch:/{print $NF}')
      finalized_slotnum=$((finalized_epoch * 32))
      block_info=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --blockid $finalized_slotnum --verbose)
      echo "Finalized slot:\n$block_info"
      ;;
    "finalized_slot_exec_payload")
      # Get the finalized slot of the network
      finalized_epoch=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain chain status --verbose | awk '/Finalized epoch:/{print $NF}')
      finalized_slotnum=$((finalized_epoch * 32))
      block_info=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --blockid $finalized_slotnum --verbose)
      execution_payload=$(echo "$block_info" | awk '/Execution payload/ {flag=1; next} flag && /^[[:blank:]]+/ {print}')
      echo "Finalized slot exec payload:\n$execution_payload"
      ;;
    "epoch_summary")
      # Get the epoch summary of the network
      #if second arg is not provided, get the current - 1 epoch, else query the specific epoch
      if [[ -z "${command[2]}" ]]; then
        current_epoch=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain epoch summary | awk -F'[: ]' '/Epoch/{print $2}')
        last_epoch=$((current_epoch - 1))
        echo "Last epoch: $last_epoch"
        epoch_summary=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain epoch summary --epoch $last_epoch)
        echo "Epoch Summary: $epoch_summary"
      else
        epoch_summary=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain epoch summary --epoch ${command[2]})
        echo "Epoch Summary: $epoch_summary"
        exit;
      fi
      ;;
    "get_slot_for_blob")
      # Get the slot for a given blob
      if [[ -z "${command[2]}" ]]; then
        echo "Please provide a blob tx hash as the second argument or send a blob now"
        echo "Would you like to send a blob right now? (y/n)"
        read -r response
        if [[ $response == y ]]
        then
          echo "Sending single blob to the network"
          blob_hash=$(${0} send_blob 1 | awk '/Result:/{print $NF}' | awk -F ':' '{print $2}')
          echo "Waiting for blob to be included in a block (sleeping 30 seconds)"
          sleep 30
          ${0} get_slot_for_blob $blob_hash
          exit;
        else
          echo "Exiting without sending a blob to the network"
          exit;
        fi
        exit;
      else
        blob=${command[2]}
        block_hash=$(curl -s -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["'$blob'"],"id":0}' https://$sops_name:$sops_password@rpc.$prefix-$network.$domain | jq .result.blockHash)
        get_block_timestamp=$(curl -s -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBlockByHash","params":['$block_hash'],"id":0}' https://$sops_name:$sops_password@rpc.$prefix-$network.$domain | jq -r .result.timestamp)
        slot=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --block-time=$get_block_timestamp | awk '/Slot/{print $NF}')
        echo "Slot for blob $blob: $slot"
        exit;
      fi
      ;;
    "get_slot_for_blob_verbose")
      # Get the slot for a given blob
      if [[ -z "${command[2]}" ]]; then
        echo "Please provide a blob tx hash as the second argument or send a blob now"
        echo "Would you like to send a blob right now? (y/n)"
        read -r response
        if [[ $response == y ]]
        then
          echo "Sending single blob to the network"
          blob_hash=$(${0} send_blob 1 | awk '/Result:/{print $NF}' | awk -F ':' '{print $2}')
          echo "Waiting for blob to be included in a block (sleeping 30 seconds)"
          sleep 30
          ${0} get_slot_for_blob_verbose $blob_hash
          exit;
        else
          echo "Exiting without sending a blob to the network"
          exit;
        fi
        exit;
      else
        blob=${command[2]}
        block_hash=$(curl -s -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["'$blob'"],"id":0}' https://$sops_name:$sops_password@rpc.$prefix-$network.$domain | jq .result.blockHash)
        get_block_timestamp=$(curl -s -X POST -H "Content-Type: application/json" -d '{"jsonrpc":"2.0","method":"eth_getBlockByHash","params":['$block_hash'],"id":0}' https://$sops_name:$sops_password@rpc.$prefix-$network.$domain | jq -r .result.timestamp)
        slot=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --block-time=$get_block_timestamp)
        echo "Slot for blob $blob: $slot"
        exit;
      fi
      ;;
    "whose_validator_for_slot")
      # Get validator for specific slot
      if [[ -z "${command[2]}" ]]; then
        echo "Please provide a slot number as the second argument"
        echo "  Example: ${0} whose_validator_for_slot 100"
        exit;
      else
        slot=${command[2]}
        proposer_index=$(ethdo --connection=https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain block info --blockid=$slot --json | jq -r .message.proposer_index)
        curl -s https://bootnode-1.srv.4844-devnet-7.ethpandaops.io/meta/api/v1/validator-ranges.json | jq .ranges | jq -r 'to_entries[] | "\(.key | split("-") | .[0]),\(.key | split("-") | .[1] | tonumber - 1),\(.value)"' > validator.csv
        declare -A validators
        while IFS="," read -r low high whose
        do
          for i in $(seq ${low} ${high})
          do
            validators["${i}"]="${whose}"
          done
        done < validator.csv
        echo ${validators["$proposer_index"]}
        rm validator.csv
        exit;
      fi
      ;;
    "get_enrs")
      # Get the ENRs of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[] | .consensus.enr'
      ;;
    "get_enodes")
      # Get the enodes of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[] | .execution.enode'
      ;;
    "get_peerid")
      # Get the peerid of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[] | .consensus.peer_id'
      ;;
    "get_rpc")
      # Get the rpc of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[] | .execution.rpc_uri'
      ;;
    "get_beacon")
      # Get the beacon of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[] | .consensus.beacon_uri'
      ;;
    "get_inventory")
      # Get the inventory of the network
      curl -s https://config.$prefix-$network.$domain/api/v1/nodes/inventory | jq -r '.ethereum_pairs[]'
      ;;
    "fork_choice")
      # Get the fork choice of the network
      curl -s https://$sops_name:$sops_password@bn.$node.srv.$prefix-$network.$domain/eth/v1/debug/fork_choice | jq '.fork_choice_nodes | .[-1]'
      ;;
    "send_blob")
      # Get a private key from a mnemonic
      privatekey=$(ethereal hd keys --path="m/44'/60'/0'/0/2" --seed="$sops_mnemonic" | awk '/Private key/{print $NF}')
      if [[ -z "${command[2]}" ]]; then
        # sending only one blob
        docker run --platform linux/x86_64 --rm ghcr.io/flcl42/send-blobs:latest https://rpc.$prefix-$network.$domain 1 "$privatekey" 0x000000000000000000000000000000000000f1c1
        exit;
      else
        docker run --platform linux/x86_64 --rm ghcr.io/flcl42/send-blobs:latest https://rpc.$prefix-$network.$domain ${command[2]} "$privatekey" 0x000000000000000000000000000000000000f1c1
        exit;
      fi
      ;;
      "deposit")
      if [[ $# -ne 3 ]]; then
        echo "Deposit calls for exactly 2 arguments!"
        echo "  Usage: ${0} deposit startIndex endIndex"
        echo "  Example: ${0} deposit 0 10"
        exit;
      else
        deposit_path="m/44'/60'/0'/0/3"
        privatekey=$(ethereal hd keys --path="$deposit_path" --seed="$sops_mnemonic" | awk '/Private key/{print $NF}')
        publickey=$(ethereal hd keys --path="$deposit_path" --seed="$sops_mnemonic" | awk '/Ethereum address/{print $NF}')
        fork_version=$(curl -s https://config.$prefix-$network.$domain/cl/config.yaml | yq -r '.GENESIS_FORK_VERSION')
        deposit_contract_address=$(curl -s https://config.$prefix-$network.$domain/cl/config.yaml | yq -r '.DEPOSIT_CONTRACT_ADDRESS')
        eth2-val-tools deposit-data --source-min=${command[2]} --source-max=${command[3]} --amount=32000000000 --fork-version=$fork_version --withdrawals-mnemonic="$sops_mnemonic" --validators-mnemonic="$sops_mnemonic" > deposits_$prefix-$network-${command[2]}_${command[3]}.txt
        # ask if you want to deposit to the network
        echo "Are you sure you want to make a deposit to the network for validators ${command[2]} to ${command[3]}? (y/n)"
        read -r response
        if [[ $response == "y" ]]; then
          while read x; do
            account_name="$(echo "$x" | jq '.account')"
            pubkey="$(echo "$x" | jq '.pubkey')"
            echo "Sending deposit for validator $account_name $pubkey"
            ethereal beacon deposit \
              --allow-unknown-contract=true \
              --address="$deposit_contract_address" \
              --connection=https://rpc.$prefix-$network.$domain \
              --data="$x" \
              --value="32000000000" \
              --from="$publickey" \
              --privatekey="$privatekey"
            echo "Sent deposit for validator $account_name $pubkey"
            sleep 2
          done < deposits_$prefix-$network-${command[2]}_${command[3]}.txt
        else
          echo "Exiting without depositing to the network"
          exit;
        fi
        echo
        if 
        exit;
      fi
      ;;

    "help")
      print_usage "${command[@]}"
      ;;

    *)
      echo "Invalid argument: $arg"
      print_usage "${command[@]}"
      ;;
  esac
done
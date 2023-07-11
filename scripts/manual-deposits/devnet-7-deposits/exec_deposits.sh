#!/bin/bash
echo "USE AT YOUR OWN RISK"
read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

source secrets.env

if [[ -z "${DEPOSIT_CONTRACT_ADDRESS}" ]]; then
  echo "need DEPOSIT_CONTRACT_ADDRESS environment var"
  exit 1 || return 1
fi

# Eth1
# ETH1_FROM_ADDR="0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
# ETH1_FROM_PRIV="0xbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"

if [[ -z "${ETH1_FROM_ADDR}" ]]; then
  echo "need ETH1_FROM_ADDR environment var"
  exit 1 || return 1
fi
if [[ -z "${ETH1_FROM_PRIV}" ]]; then
  echo "need ETH1_FROM_PRIV environment var"
  exit 1 || return 1
fi

# Iterate through lines, each is a json of the deposit data and some metadata
while read x; do
   account_name="$(echo "$x" | jq '.account')"
   pubkey="$(echo "$x" | jq '.pubkey')"
   echo "Sending deposit for validator $account_name $pubkey"
   ethereal beacon deposit \
      --allow-unknown-contract \
      --address="$DEPOSIT_CONTRACT_ADDRESS" \
      --connection=$ETH1_NETWORK \
      --data="$x" \
      --value="$DEPOSIT_ACTUAL_VALUE" \
      --from="$ETH1_FROM_ADDR" \
      --privatekey="$ETH1_FROM_PRIV"
   echo "Sent deposit for validator $account_name $pubkey"
   sleep 3
done < "$DEPOSIT_DATAS_FILE_LOCATION.txt"



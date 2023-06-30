#!/bin/zsh

curl -s https://bootnode-1.srv.4844-devnet-7.ethpandaops.io/meta/api/v1/validator-ranges.json | jq .ranges | jq -r 'to_entries[] | "\(.key | split("-") | .[0]),\(.key | split("-") | .[1] | tonumber - 1),\(.value)"' > validator.csv
declare -A validators
while IFS="," read -r low high whose
do
  for i in $(seq ${low} ${high})
  do
    # validators+=("${i}"="${whose}")
    validators["${i}"]="${whose}"
  done
done < validator.csv

[ $# -ge 1 ] && input="$1" || read input

echo ${validators["$input"]}
rm validator.csv
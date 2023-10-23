<div align="center"><img src="./docs/images/dencun-logo-200px.png"/></div>
<h2 align="center">🐼 ❤️.oO<br>"Pandas love blobs"</h2>
<h1 align="center">Infrastructure code for Dencun Dev/Testnets</h1>

<p align="center">
<a href="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-ansible.yaml"><img src="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-ansible.yaml/badge.svg"></a>
<a href="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-terraform.yaml"><img src="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-terraform.yaml/badge.svg"></a>
<a href="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-helm.yaml"><img src="https://github.com/ethpandaops/dencun-testnet/actions/workflows/lint-helm.yaml/badge.svg"></a>
</p>

This repository contains the infrastructure code used to setup [EIP4844](https://www.eip4844.com/) and other Dencun related EIPs dev/testnets. A lot of the code uses reusable components either provided by our [ansible collection](https://github.com/ethpandaops/ansible-collection-general) or our [helm charts for kubernetes](https://github.com/ethpandaops/ethereum-helm-charts/).

# Networks

Status | Network | Links | Ansible | Terraform | Kubernetes
------ | ------- | ----  |  -----  | -------   | ----------
 🟢 Active | [devnet-10](https://dencun-devnet-10.ethpandaops.io/) | [Network config](network-configs/devnet-10) / [Inventory](ansible/inventories/devnet-10/inventory.ini)  | [🔗](ansible/inventories/devnet-10) | [🔗](terraform/devnet-10) | [🔗](kubernetes/devnet-10)
 🟢 Active | [devnet-9](https://dencun-devnet-9.ethpandaops.io/) | [Network config](network-configs/devnet-9) / [Inventory](ansible/inventories/devnet-9/inventory.ini)  | [🔗](ansible/inventories/devnet-9) | [🔗](terraform/devnet-9) | [🔗](kubernetes/devnet-9)
 🔴 Off | [devnet-8](https://dencun-devnet-8.ethpandaops.io/) | [Network config](network-configs/devnet-8) / [Inventory](ansible/inventories/devnet-8/inventory.ini)  | [🔗](ansible/inventories/devnet-8) | [🔗](terraform/devnet-8) | [🔗](kubernetes/devnet-8)
 🔴 Off | [devnet-7](https://4844-devnet-7.ethpandaops.io/) | [Network config](network-configs/devnet-7) / [Inventory](ansible/inventories/devnet-7/inventory.ini)  | [🔗](ansible/inventories/devnet-7) | [🔗](terraform/devnet-7) | [🔗](kubernetes/devnet-7)
 🔴 Off | [sepolia-sf1](https://4844-sepolia-sf1.ethpandaops.io/) | [Network config](network-configs/sepolia-sf1) / [Inventory](ansible/inventories/sepolia-shadowfork-1/inventory.ini) | [🔗](ansible/inventories/sepolia-shadowfork-1) | [🔗](terraform/sepolia-shadowfork-1) | [🔗](kubernetes/sepolia-sf1)
 🔴 Off | [devnet-6](https://4844-devnet-6.ethpandaops.io/)    | [Network config](network-configs/devnet-6) / [Inventory](ansible/inventories/devnet-6/inventory.ini)  | [🔗](ansible/inventories/devnet-6) | [🔗](terraform/devnet-6) | [🔗](kubernetes-archive/devnet-6)
 🔴 Off | [devnet-5](https://4844-devnet-5.ethpandaops.io/)    | [Network config](network-configs/devnet-5) / [Inventory](ansible/inventories/devnet-5/inventory.ini)  | [🔗](ansible/inventories/devnet-5) | [🔗](terraform/devnet-5) | [🔗](kubernetes-archive/devnet-5)
 🔴 Off | [devnet-4](https://4844-devnet-4.ethpandaops.io/)    | [Network config](network-configs/devnet-4) / [Inventory](ansible/inventories/devnet-4/inventory.ini)  | [🔗](ansible/inventories/devnet-4) | [🔗](terraform/devnet-4) | [🔗](kubernetes-archive/devnet-4)

# Development
## Version management for tools

We're using [asdf](https://github.com/asdf-vm/asdf) to make sure that we all use the same versions across tools. Our repositories should contain versions defined in .tools-versions.

You can then use [`./setup.sh`](./asdf-setup.sh) to install all dependencies.


# Update all sops files
```
# Find all .sops.* and *.enc.* files and update their keys
find . -type d -name "vendor" -prune -o \( -type f \( -name "*.sops.*" -o -name "*.enc.*" \) \) -exec sops updatekeys {} -y \;
```

## Genesis allocation used:
Here's a table of where the keys are used

| Account Index | Component Used In | Private Key Used | Public Key Used | Comment                           |
|---------------|-------------------|------------------|----------------|-----------------------------------|
| 0             | tx_fuzz blobs     | ✅               |                | Spams blobs on the network        |
| 1             | tx_fuzz_txs       | ✅               |                | Spams tx on the network           |
| 2             | mev_flood_signing_key| ✅            |                | Spams mev-able txs on the network |
| 3             | mev_flood_user_key| ✅               |                | Spams mev-able txs on the network |
| 4             | faucet-1          | ✅               |                | Faucet 1                          |
| 5             | faucet-2          | ✅               |                | Faucet 2                          |
| 6             | mev_flood_private_key | ✅           |                | Spams mev-able txs on the network |
| 7-29          |                   |                  |                |                                   |

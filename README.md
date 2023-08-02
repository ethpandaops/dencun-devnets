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
 🟢 Active | [devnet-8](https://dencun-devnet-8.ethpandaops.io/) | [Network config](network-configs/devnet-8) / [Inventory](ansible/inventories/devnet-8/inventory.ini)  | [🔗](ansible/inventories/devnet-8) | [🔗](terraform/devnet-7) | [🔗](kubernetes/devnet-7)
 🔴 Off | [devnet-7](https://4844-devnet-7.ethpandaops.io/) | [Network config](network-configs/devnet-7) / [Inventory](ansible/inventories/devnet-7/inventory.ini)  | [🔗](ansible/inventories/devnet-7) | [🔗](terraform/devnet-7) | [🔗](kubernetes/devnet-7)
 🔴 Off | [sepolia-sf1](https://4844-sepolia-sf1.ethpandaops.io/) | [Network config](network-configs/sepolia-sf1) / [Inventory](ansible/inventories/sepolia-shadowfork-1/inventory.ini) | [🔗](ansible/inventories/sepolia-shadowfork-1) | [🔗](terraform/sepolia-shadowfork-1) | [🔗](kubernetes/sepolia-sf1)
 🔴 Off | [devnet-6](https://4844-devnet-6.ethpandaops.io/)    | [Network config](network-configs/devnet-6) / [Inventory](ansible/inventories/devnet-6/inventory.ini)  | [🔗](ansible/inventories/devnet-6) | [🔗](terraform/devnet-6) | [🔗](kubernetes-archive/devnet-6)
 🔴 Off | [devnet-5](https://4844-devnet-5.ethpandaops.io/)    | [Network config](network-configs/devnet-5) / [Inventory](ansible/inventories/devnet-5/inventory.ini)  | [🔗](ansible/inventories/devnet-5) | [🔗](terraform/devnet-5) | [🔗](kubernetes-archive/devnet-5)
 🔴 Off | [devnet-4](https://4844-devnet-4.ethpandaops.io/)    | [Network config](network-configs/devnet-4) / [Inventory](ansible/inventories/devnet-4/inventory.ini)  | [🔗](ansible/inventories/devnet-4) | [🔗](terraform/devnet-4) | [🔗](kubernetes-archive/devnet-4)

# Development
## Version management for tools

We're using [asdf](https://github.com/asdf-vm/asdf) to make sure that we all use the same versions across tools. Our repositories should contain versions defined in .tools-versions.

You can then use [`./setup.sh`](./asdf-setup.sh) to install all dependencies.

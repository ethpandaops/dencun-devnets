<div align="center"><img src="./docs/images/4844-logo-200px.png"/></div>
<h2 align="center">🐼 ❤️.oO<br>"Pandas love blobs"</h2>
<h1 align="center">Infrastructure code for EIP4844 Dev/Testnets</h1>

<p align="center">
<a href="https://github.com/ethpandaops/4844-testnet/actions/workflows/ansible_lint.yaml"><img src="https://github.com/ethpandaops/4844-testnet/actions/workflows/ansible_lint.yaml/badge.svg"></a>
<a href="https://github.com/ethpandaops/4844-testnet/actions/workflows/terraform_lint.yaml"><img src="https://github.com/ethpandaops/4844-testnet/actions/workflows/terraform_lint.yaml/badge.svg"></a>
</p>

This repository contains the infrastructure code used to setup [EIP4844](https://www.eip4844.com/) dev/testnets. A lot of the code uses reusable components either provided by our [ansible collection](https://github.com/ethpandaops/ansible-collection-general) or our [helm charts for kubernetes](https://github.com/ethpandaops/ethereum-helm-charts/).

# Networks

Status   | Network    | Links   | Ansible                                                      | Terraform | ArgoCD
------   | --------   | ----     |  -----                                                       | -------   | ------
 🟢 Live | [devnet-4](https://eip4844-devnet-4.ethpandaops.io/)   | [Network config](network-configs/devnet-4) / [Inventory](https://bootnode-1.srv.4844-devnet-4.ethpandaops.io/meta/api/v1/inventory.json)     | [🔗](ansible/inventories/devnet-4) | [🔗](terraform/environments/devnet-4) | 🛠️ Soon

# Development
## Version management for tools

We're using [asdf](https://github.com/asdf-vm/asdf) to make sure that we all use the same versions across tools. Our repositories should contain versions defined in .tools-versions.

You can then use [`./asdf-setup.sh`](./asdf-setup.sh) to install all dependencies.

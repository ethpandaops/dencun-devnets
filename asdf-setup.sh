#!/bin/bash

# Plugin list
ASDF_PYAPP_INCLUDE_DEPS=1 asdf plugin add ansible https://github.com/amrox/asdf-pyapp.git
asdf plugin add ansible-lint https://github.com/amrox/asdf-pyapp.git
asdf plugin add shellcheck https://github.com/luizm/asdf-shellcheck.git
asdf plugin add sops https://github.com/feniix/asdf-sops.git
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git

asdf install

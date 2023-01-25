# ethpandaops.general.cl_bootnode

This role will run [eth2-bootnode]](https://github.com/protolambda/eth2-bootnode) within a docker container.

## Requirements

You'll need docker on the target system. Make sure to install it upfront.

## Role Variables

Default variables are defined in [defaults/main.yaml](defaults/main.yaml)

## Dependencies

You'll need docker to run this role. One way of installing docker could be via ansible galaxy with the following dependencies set within `requirements.yaml`:

```yaml
roles:
- src: geerlingguy.docker
  version: latest
- src: geerlingguy.pip
  version: latest
```

## Example Playbook

Your playbook could look like this:

```yaml
- hosts: localhost
  become: true
  roles:
  - role: geerlingguy.docker
  - role: geerlingguy.pip
    pip_install_packages:
    - name: docker
  - role: ethpandaops.general.cl_bootnode
```

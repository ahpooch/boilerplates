# Terraform Proxmox provider 
## This example uses `bgb/terraform-provider-proxmox`
Terraform registry: https://registry.terraform.io/providers/bpg/proxmox/latest
GitHub: https://github.com/bpg/terraform-provider-proxmox/tree/main

## Alternative Terraform Proxmox provider is `telmate/terraform-provider-proxmox`
Terraform registry: https://registry.terraform.io/providers/Telmate/proxmox/latest
GitHub: https://github.com/Telmate/terraform-provider-proxmox

# Proxmox environment assumptions
Node name is `proxmox`.
The node has local storages named `local` and `local-zfs`.
The `Snippets` content type is enabled in the local storage.
Default Linux Bridge `vmbr0` is VLAN aware (datacenter -> proxmox -> network).
Proxmox Template VM (vm_id = 9000) already [provisioned with Packer](https://github.com/ahpooch/boilerplates/tree/main/packer/proxmox/ubuntu_24.04_noble-numbat_explanatory) alternatively you need to use Cloud-Init to set new user on VM clonned from regular official image.

# Usage
## Terraform Installation on Windows
Download terraform.exe from https://developer.hashicorp.com/terraform/install
Move terraform.exe to one of directories in $env:PATH.
Or you could place it in `C:\Program Files\Tools\` and add `C:\Program Files\Tools` to User and Machine Paths.

## Initialize Terraform (provider plugin installation)
Make sure you set current directory to terraform project folder, then run
`terraform init`
## Terraform Validate (check if current configuration in this project is valid)
`terraform validate`
## Terraform Plan (check changes terraform planned, based on project configuration)
`terraform plan`
## Terraform Apply (apply changes with terraform, based on project configuration)
`terraform apply`
## Terraform destroy (remove changes terraform made, based on project configuration)
`terraform destroy`

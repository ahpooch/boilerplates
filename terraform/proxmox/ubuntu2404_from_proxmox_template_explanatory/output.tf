# This output with created vm IP will be print to the console when `terraform apply` will be finished.
output "vm_ipv4_address" {
  value = proxmox_virtual_environment_vm.ubuntu2404.ipv4_addresses[1][0]
}
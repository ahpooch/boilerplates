# Ubuntu 24.04 LTS (Noble Numbat) auto variables.

# Operating System settings
### Reference for iso_checksum: https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox/latest/components/builder/clone#required
os_name                     = "Ubuntu 24.04.02 LTS (Noble Numbat)"
iso_url                     = "https://releases.ubuntu.com/noble/ubuntu-24.04.2-live-server-amd64.iso"
### iso_ckecksum will be retrieved from the internet page
iso_checksum                = "file:https://releases.ubuntu.com/24.04/SHA256SUMS"

# Proxmox settings
proxmox_node_name           = "proxmox"
### set this to false if you secured proxmox web console with certificate
proxmox_insecure_connection = true

# Virtual machine settings
## Use 'vm_disk_storage_pool = "local-lvm"' if you didn't install proxmox over zfs
vm_name                     = "ubuntu-server-noble-numbat"
vm_id                       = 9000
vm_os_type                  = "l26"
vm_tags                     = "template;ubuntu"
vm_cpu_size                 = 2
vm_ram_size                 = 4096
vm_disk_storage_pool        = "local-zfs"
vm_disk_format              = "raw"
vm_disk_controller_type     = "virtio"
vm_disk_size                = 20
vm_guest_os_timezone        = "Europe/Moscow"
resource "proxmox_virtual_environment_vm" "ubuntu2404" {
  name        = "ubuntu2404-terraform-clone"
  description = "Managed by Terraform"
  tags        = ["terraform", "ubuntu"]
  node_name   = var.proxmox_node_name
  vm_id       = 200

  clone {
    # ubuntu-server-noble-numbat template vm id
    vm_id = 9000
  }

  agent {
    # Activate qemu-agent
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, using Packer.
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = true
  }
  
  operating_system {
    type = "l26"
  }
 
  scsi_hardware = "virtio-scsi-pci" # VirtIO SCSI (default). https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#scsi_hardware-6

  cpu {
    cores = 1
    sockets = 1
    type = "x86-64-v2-AES"  # recommended for modern CPUs
  }
  
  memory {
    dedicated = 2048
    floating  = 2048 # set equal to dedicated to enable ballooning
  }
  
  disk {
    datastore_id = var.proxmox_storage_name
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 24
  }
  
  boot_order = ["virtio0"]
  
  network_device {
    bridge = "vmbr0"
    model = "virtio"
  }
  
  initialization {
    datastore_id = var.proxmox_storage_name

    ip_config {
      ipv4 {
        address = "dhcp"
        # OR
        # address = "x.x.x.x/x"
        # gateway = "x.x.x.x"
      }
    }

    dns {
      servers = [ "8.8.8.8" ]
    }
  
    # users account can be set if not provisioned in template VM.
    # user_account {
    #  username = "ubuntu"
    #  keys     = [trimspace(data.local_file.ssh_public_key.content)]
    # }
  }
}
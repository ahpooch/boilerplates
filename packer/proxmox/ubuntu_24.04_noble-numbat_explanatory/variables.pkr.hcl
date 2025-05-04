# Ubuntu 24.04 LTS (Noble Numbat) variables definition.

### Region Start: Proxmox variables
variable "proxmox_api_url" {
  type = string
  description = "URL to your proxmox api in format https://IP:Port/api2/json"
}

variable "proxmox_api_token_id" {
  type = string
  description = "API Token of a Proxmox users with sufficient rights to build template"
}

variable "proxmox_api_token_secret" {
  type = string
  description = "API Token secret of Proxmox users with sufficient rights to build template"
  sensitive = true
}

variable "proxmox_insecure_connection" {
  type = bool
  description = "Do not validate the Proxmox Server TLS certificate."
  default = false
}

variable "proxmox_node_name" {
  type = string
  description = "Proxmox node name."
  default = "proxmox"
}
### Region End: Proxmox variables

### Region Start: Template Account Credentials
variable "guest_gecos" {
  type = string
  description = "The gecos for the default user on operating system."
}

variable "guest_username" {
  type = string
  description = "The username for the default user on operating system."
}

variable "guest_password" {
  type = string
  description = "The password to login for the default user on operating system."
}

variable "guest_password_encrypted" {
  type = string
  description = "The encrypted password to login for the default user on operating system."
}

variable "guest_ssh_key" {
  type = string
  description = "The ssh public key for the default user on operating system."
}
### Region End: Template Account Credentials

### Region Start: Operating System
variable "os_name" {
  type = string
  description = "Name and version of the guest operating system."
}

variable "iso_url" {
  type = string
  description = "URL for the ISO to download."
}

variable "iso_checksum" {
  type = string
  description = "The checksum for the ISO file."
}
### Region End: Operating System

### Region Start: Virtual Machine Settings
variable "vm_name" {
  type = string
  description = "Name of the new VM to create."
}

variable "vm_id" {
  type = number
  description = "Id of of the new VM to create."
}

variable "vm_os_type" {
  type = string
  description = "The operating system. Can be wxp, w2k, w2k3, w2k8, wvista, win7, win8, win10, l24 (Linux 2.4), l26 (Linux 2.6+), solaris or other. Defaults to other."
}

variable "vm_tags" {
  type = string
  description = "Tags to set on the new VM."
}

variable "vm_cpu_size" {
  type    = number
  description = "Number of CPU cores."
  default = 1
}

variable "vm_ram_size" {
  type = number
  description = "Amount of RAM in MB."
}

variable "vm_disk_storage_pool" {
  type = string
  description = "Disk storage pool on Proxmox (e.g., local-lvm or local-zfs )."
}

variable "vm_disk_format" {
  type = string
  description = "Disk format)."
  default = "raw"
}

variable "vm_disk_controller_type" {
  type        = string
  description = "VM disk controller type"
  default     = "virtio"
}

variable "vm_disk_size" {
  type = number
  description = "The size of the disk in Gb."
}

variable "vm_guest_os_timezone" {
  type = string
  description = "Timezone."
}
### Region End: Virtual Machine Settings
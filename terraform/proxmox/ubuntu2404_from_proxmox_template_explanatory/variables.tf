variable "virtual_environment_endpoint" {
  description = "Proxmox URL in a format https://<IP_or_Hostname>:<Port>/api2/json"
  type = string
}
variable "virtual_environment_username" {
  description = "Root or username of a custom service user with sudo rights"
  type = string
}
variable "virtual_environment_password" {
  description = "Password of a root or custom service user on Proxmox"
  type = string
}
variable "proxmox_node_name" {
  description = "Promox Node Name"
  type = string
  default = "pve"
}
variable "proxmox_storage_name" {
  description = "Local storage name on Proxmox"
  type = string
  default = "local-lvm"
}
terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.77.1"
    }
  }
  required_version = ">= 1.11.4"
}
provider "proxmox" {
  endpoint = var.virtual_environment_endpoint
  
  # [!NOTE] 
  # Not all Proxmox API operations are supported via API Token. 
  # You may see errors like error creating container: 
  # received an HTTP 403 response - Reason: Permission check failed (changing feature flags for privileged container is only allowed for root@pam)
  # or error creating VM: received an HTTP 500 response - Reason: only root can set 'arch' config 
  # or Permission check failed (user != root@pam) when using API Token authentication, 
  # even when Administrator role or the root@pam user is used with the token. 
  # The workaround is to use password authentication for those operations.
  # api_token = var.virtual_environment_api_token
  # OR
  username = var.virtual_environment_username
  password = var.virtual_environment_password

  # Set insecure to false if you have Proxmox TLS configured
  insecure = true

  ssh {
    agent = true
  }
}
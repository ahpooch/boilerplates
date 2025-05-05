#cloud-config
autoinstall:
  version: 1
  early-commands:
    # Stop ssh for packer as it thinks it timed out (workaround)
    - sudo systemctl stop ssh
    # Here could be commands helpful in troubleshooting
    - ip -c address show dynamic

  # We could use 'interactive-sections' for debugging. - * means that all stages of Subiquity is interactive.
  # interactive-sections:
  #   - network
  #   - apt
  #   - *

  # Controls whether the Subiquity installer updates to a new version available in the given channel before continuing.
  refresh-installer:
    update: yes
    channel: latest/edge

  # Setting template VM hostname
  hostname: ${hostname}

  # user-data block provides cloud-init user data, which will be merged with the user data the installer produces.
  # If you supply this, you don’t need to supply an 'identity' section.
  user-data:
  # Reference: https://canonical-subiquity.readthedocs-hosted.com/en/latest/reference/autoinstall-reference.html#ai-user-data
  # Cloud-Init Full Reference: https://cloudinit.readthedocs.io/en/20.4.1/topics/modules.html#users-and-groups
  # Example: https://forum.proxmox.com/threads/how-to-enable-ssh-password-authentication-in-cloud-init-configuration.60014/
    # Default timezone: "Etc/UTC"
    timezone: ${vm_guest_os_timezone}
    disable_root: false
    
    # Provisioning desired guest user. It will substitute default user (ubuntu by default).
    # Reference: https://cloudinit.readthedocs.io/en/latest/reference/modules.html#users-and-groups
    users:
      - name:        ${guest_username}
        gecos:       ${guest_gecos}
        passwd:      ${guest_password_encrypted}
        ssh_authorized_keys: 
          - ${guest_ssh_key}
        groups:      adm, cdrom, dip, lxd, plugdev, sudo
        shell:       /bin/bash
        lock-passwd: false
        sudo:        ALL=(ALL) NOPASSWD:ALL
  
  # Keyboard layout configuration
  keyboard:
    layout: us
  
  # Locale configuration
  locale: en_US
  
  # SSH configuration
  # Reference: https://canonical-subiquity.readthedocs-hosted.com/en/latest/reference/autoinstall-reference.html#ssh
  ssh:
    install-server: true
    allow-pw: true
    ssh_quiet_keygen: true

  # Updating and upgrading packages during boot
  package_update: true
  package_upgrade: true
  
  # Installing packages
  packages:
    # Mandatory for Packer to connect to Proxmox template VM for ssh provisioning stage
    - qemu-guest-agent
    # Other optional packages
    - tree
    - iftop
    - btop
    - neofetch
  
  # Storage configuration
  # Reference: https://canonical-subiquity.readthedocs-hosted.com/en/latest/reference/autoinstall-reference.html#storage
  storage:
    layout:
      name: lvm
      sizing-policy: all

  # late-commands:
  #   # You can pause the install just before finishing to allow manual inspection/modification.
  #   # For manual inpection use Alt + F2 while in the console of Template VM on Proxmox.
  #   # Unpause by creating the "/run/finish-late" file.
  #   - while [ ! -f /run/finish-late ]; do sleep 1; done
  
  # This message is written to the cloud-init log (usually /var/log/cloud-init.log) as well as stderr (which usually redirects to /var/log/cloud-init-output.log).
  # Upon exit, this module writes the system uptime, timestamp, and cloud-init version to /var/lib/cloud/instance/boot-finished independent of any user data specified for this module.
  # Reference: https://cloudinit.readthedocs.io/en/latest/reference/modules.html#final-message
  final_message: |
    cloud-init has finished
    version: $version
    timestamp: $timestamp
    datasource: $datasource
    uptime: $uptime
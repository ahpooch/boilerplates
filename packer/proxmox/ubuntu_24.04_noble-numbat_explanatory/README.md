<p align="center"><img src="https://raw.githubusercontent.com/ahpooch/boilerplates/main/packer/proxmox/ubuntu_24.04_noble-numbat_explanatory/Ubuntu24.04_Noble_Numbat.png" />

# Description
This is a Packer build template that creates Ubuntu 24.04 LTS (Noble Numbat) VM Template on Proxmox.
This template is designed to run from Windows host, but surely could be easily changed to be run from linux.

This particular template is thoroughly commented for a learning purpose and sharing knowledge.

# Last successfuly run on
Date: 05.05.2025
Proxmox VE: 8.4.1
Packer host's operating system: Windows 11 24H2 (26100.3775)
Packer Version: v1.12.0
Packer Proxmox Plugin: packer-plugin-proxmox_v1.2.2_x5.0_windows_amd64.exe

# Before working with this project
This repository has a credentials.example.pkr.hcl file
which is template for your credentials.pkr.hcl file,
that you need to provide your credentials and other sensitive parameters for Packer.

Just copy credentials.example.pkr.hcl content to a your own credentials.pkr.hcl file.
In this repository, credentials.pkr.hcl added to .gitignore file, so that you not accidentally commit your secrets to public repo.

# Installing Packer on Windows
You can install Packer with chocolatey.
https://community.chocolatey.org/packages/packer

# Before working with Packer
This project users Proxmox Packer builder to create Proxmox virtual machines and store them as new Proxmox Virtual Machine images.
https://developer.hashicorp.com/packer/integrations/hashicorp/proxmox

## Installing Proxmox Packer builder
To install Proxmox Packer builder, add this code into your Packer configuration and run `packer init .`
```
packer {
required_version = " >= 1.12.0"
  required_plugins {
    name = {
      version = " >= v1.2.2"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}
```
Alternatively, you can install Proxmox Packer builder manually with command below.
```
packer plugins install github.com/hashicorp/proxmox
```
Proxmox Packer builder already added to `required_plugins` block, so just run `packer init .` from template directory and you good to go.

# Working with project
## Packer configuration validation
Before running Packer you should probably validate configuration first.
```shell
# Make shure you executed `cd <folder with desired Tempalate>`
packer validate .
```
Then you can build your Template
```shell
# Make shure you executed `cd <folder with desired Tempalate>`
packer build .
```

# Debugging
If you run packer from Windows then log, named like `packer-logXXXXXXXXX`, will be at `%USERPROFILE%\AppData\Local\Temp`
Use this command to quickly open log in vscode using powershell
```Powershell
code $(Get-ChildItem $env:USERPROFILE\Appdata\Local\Temp -Filter "packer-log*" | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName)
```

### Using -debug option 
Use -debug option to see detailed steps in console and have a pause between them.
After each step you will be ask to press enter to continue.
```Powershell
packer build -debug ...
```

### Using -on-error=ask
If your packer build is unstable you should use -on-error=ask,
so that packer not destroy VM on Proxmox rightaway and you could work on it to elaborate current problem.
```Powershell
packer build -on-error=ask
```

### Set PACKER_LOG to 1
Setting PACKER_LOG to 1 shows extensive logging in console when running packer commands.
```Powershell
$env:PACKER_LOG = 1
```

### Using breakpoint provisioner for debugging
You could use provisioner breakpoint in Packer template to pause build and see VM state
```  
provisioner "breakpoint" {
    disable = false
    note    = "this is a breakpoint"
}
```

# How to investigate VM on Proxmox in the build process
if installation of Ubuntu image unexpectedly stuck at any time you could do so:
press Alt+F2 to get a working console.
- Read `/var/log/installer/subiquity-*.log files to get the network configuration correct.
- Read `/var/log/syslog` to debug the YAML parsing issues around the late-commands.
Source: https://nickcharlton.net/posts/automating-ubuntu-2004-installs-with-packer.html


# About autoinstall
Here is an official documentation for autoinstall
https://canonical-subiquity.readthedocs-hosted.com/en/latest/intro-to-autoinstall.html
This template uses Ubuntu autoinstall which was introduced in Ubuntu 20.04.
Before version 20.04, Ubuntu was using classic Debian Installer (d-i) using preseed.conf files.

# Get cloud-init logs from VM
```shell
# Collect logs. They will be at /home/<server-name>/cloud-init.tar.gz
cloud-init collect-logs
# Extract logs to read them
tar -xvzf /home/server_name/cloud-init.tar.gz
```

# If Packer can not connect to VM
```shell
# sshd status could show that there is some unsuccessful attempts to connect to ssh server.
### Example: Invalid user <user> from <ip> port <port>
### pam_unix(sshd:auth): check pass; user unknown
# In this case the reason is wrong password when Packer attempt to connect to VM.
# Work with virables in Packer.
systemctl status sshd
```

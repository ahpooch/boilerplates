#!/bin/bash

# Cleaning apt
## Removing dependencies and unneeded configuration files
apt-get -y autoremove --purge
## Clearing the local repository of retrieved package files
apt-get -y clean

# Cleaning temp directories
rm -rf /tmp/*
rm -rf /var/tmp/*

# Truncating logs
if [ -f /var/log/wtmp ]; then
    truncate -s0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
    truncate -s0 /var/log/lastlog
fi

# Using safe method of cleaning cloud-init
## https://github.com/canonical/cloud-init/issues/4056#issuecomment-1546232434
## After this commands, in directory '/etc/cloud/cloud.cfg.d' will be only this files:
## [05_logging.cfg, 90_dpkg.cfg, 91_kernel_cmdline_url.cfg, curtin-preserve-sources.cfg]
cloud-init clean --seed --logs --machine-id
echo "uninitialized" > /etc/machine-id

# Remove Cloud-Init file that we used to configure template
rm -f /etc/cloud/cloud.cfg.d/*kernel_cmdline_url.cfg

# Resetting hostname
truncate -s0 /etc/hostname

# Cleaninig history
history -c && history -w
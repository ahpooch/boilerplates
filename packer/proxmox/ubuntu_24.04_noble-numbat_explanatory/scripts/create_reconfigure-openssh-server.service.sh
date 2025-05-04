# Script to create oneshot first boot only service to regenerate openssh host keys
# https://www.cyberciti.biz/faq/howto-regenerate-openssh-host-keys/

PURPLE="\e[0;35m"
ENDCOLOR="\e[0m"

echo -e "${PURPLE}Creating oneshot first boot only service to regenerate openssh host keys${ENDCOLOR}"

# Cleaning current openssh host keys
echo -e "${PURPLE}Cleaning current openssh host keys${ENDCOLOR}"
rm -f /etc/ssh/ssh_host_*

# Creating regenerate host keys script
echo -e "${PURPLE}Creating regenerate host keys script at /usr/local/bin/regenerate-openssh-host-keys.sh${ENDCOLOR}"
tee /usr/local/bin/regenerate-openssh-host-keys.sh <<EOL
#!/bin/bash
echo "Oneshot script started at $(date)" > /var/log/regenerate-openssh-host-keys.log
echo "Reconfiguring openssh-server to regenerate host keys" >> /var/log/regenerate-openssh-host-keys.log
echo "Runnig 'dpkg-reconfigure openssh-server'" >> /var/log/regenerate-openssh-host-keys.log
if [ test -f /etc/ssh/ssh_host_dsa_key ]; then
    dpkg-reconfigure openssh-server >> /var/log/regenerate-openssh-host-keys.log
fi
exit 0
EOL

# Adding execute rights to script
echo -e "${PURPLE}Adding execute rights to script${ENDCOLOR}"
chmod +x /usr/local/bin/regenerate-openssh-host-keys.sh

# Creating unit file for first boot oneshot service
echo -e "${PURPLE}Creating unit file for first boot oneshot service${ENDCOLOR}"
tee /etc/systemd/system/reconfigure-openssh-server.service <<EOL
[Unit]
Description=Regenerate openssh host keys at first start of clonned VM.
ConditionFirstBoot=yes
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/regenerate-openssh-host-keys.sh
User=root
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd manager configuration
echo -e "${PURPLE}Reloading systemd manager configuration${ENDCOLOR}"
systemctl daemon-reload
# Enable reconfigure-openssh-server.service
echo -e "${PURPLE}Enabling reconfigure-openssh-server.service${ENDCOLOR}"
systemctl enable reconfigure-openssh-server.service
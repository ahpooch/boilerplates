PURPLE="\e[0;35m"
ENDCOLOR="\e[0m"

echo -e "${PURPLE}Enabling Proxmox Cloud-Init for VM clonned from template${ENDCOLOR}"
touch /etc/cloud/cloud.cfg.d/99_pve.cfg
echo -e "${PURPLE}Setting datasource_list in /etc/cloud/cloud.cfg.d/99_pve.cfg${ENDCOLOR}"
tee /etc/cloud/cloud.cfg.d/99_pve.cfg <<EOF >/dev/null
datasource_list: [ConfigDrive, NoCloud]
EOF

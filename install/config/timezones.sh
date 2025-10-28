# Ensure timezone can be updated without needing to sudo
tee /etc/sudoers.d/omarchy-tzupdate >/dev/null <<EOF
%wheel ALL=(root) NOPASSWD: /usr/bin/tzupdate, /usr/bin/timedatectl
EOF
chmod 0440 /etc/sudoers.d/omarchy-tzupdate

#!/bin/bash
# Ensure timezone can be updated without needing to sudo
COMMANDS="/usr/bin/timedatectl"
if [[ -f /usr/bin/tzupdate ]]; then
    COMMANDS="/usr/bin/tzupdate, $COMMANDS"
fi

sudo tee /etc/sudoers.d/omarchy-tzupdate >/dev/null <<EOF
%wheel ALL=(root) NOPASSWD: $COMMANDS
EOF
sudo chmod 0440 /etc/sudoers.d/omarchy-tzupdate

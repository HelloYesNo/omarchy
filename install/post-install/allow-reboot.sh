# Allow passwordless reboot for the installer - removed in first-run
tee /etc/sudoers.d/99-omarchy-installer-reboot >/dev/null <<EOF
$USER ALL=(ALL) NOPASSWD: /usr/bin/reboot
EOF
chmod 440 /etc/sudoers.d/99-omarchy-installer-reboot

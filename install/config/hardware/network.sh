# Ensure iwd service will be started
systemctl enable iwd.service

# Prevent systemd-networkd-wait-online timeout on boot
systemctl disable systemd-networkd-wait-online.service
systemctl mask systemd-networkd-wait-online.service

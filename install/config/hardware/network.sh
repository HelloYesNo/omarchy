# Ensure iwd service will be started
sudo systemctl enable iwd.service

# Prevent systemd-networkd-wait-online timeout on boot
sudo systemctl mask systemd-networkd-wait-online.service 2>/dev/null || true

# On Fedora, NetworkManager is the network manager — remove systemd-networkd's ethernet config
# but keep the service running (needed for low-level network device initialization)
if [[ ${DISTRO_ID:-} == "fedora" ]]; then
  for f in /etc/systemd/network/{20-wired,*.network}; do
    [[ -f $f ]] && sudo mv "$f" "$f.disabled" 2>/dev/null || true
  done
  # Ensure NM's connection storage directory exists (can be missing on some installs)
  sudo mkdir -p /etc/NetworkManager/system-connections
fi

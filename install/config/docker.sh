# Configure Docker daemon:
# - limit log size to avoid running out of disk
# - use host's DNS resolver
mkdir -p /etc/docker
tee /etc/docker/daemon.json >/dev/null <<'EOF'
{
    "log-driver": "json-file",
    "log-opts": { "max-size": "10m", "max-file": "5" },
    "dns": ["172.17.0.1"],
    "bip": "172.17.0.1/16"
}
EOF

# Expose systemd-resolved to our Docker network
mkdir -p /etc/systemd/resolved.conf.d
echo -e '[Resolve]\nDNSStubListenerExtra=172.17.0.1' | tee /etc/systemd/resolved.conf.d/20-docker-dns.conf >/dev/null
systemctl restart systemd-resolved

# Start Docker automatically
systemctl enable docker

# Give this user privileged Docker access
usermod -aG docker ${USER}

# Prevent Docker from preventing boot for network-online.target
mkdir -p /etc/systemd/system/docker.service.d
tee /etc/systemd/system/docker.service.d/no-block-boot.conf <<'EOF'
[Unit]
DefaultDependencies=no
EOF

systemctl daemon-reload

# Allow nothing in, everything out
ufw default deny incoming
ufw default allow outgoing

# Allow ports for LocalSend
ufw allow 53317/udp
ufw allow 53317/tcp

# Allow SSH in
ufw allow 22/tcp

# Allow Docker containers to use DNS on host
ufw allow in proto udp from 172.16.0.0/12 to 172.17.0.1 port 53 comment 'allow-docker-dns'

# Turn on the firewall
ufw --force enable

# Enable UFW systemd service to start on boot
systemctl enable ufw

# Turn on Docker protections
ufw-docker install
ufw reload

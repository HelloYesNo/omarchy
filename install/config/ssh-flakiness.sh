# Solve common flakiness with SSH
echo "net.ipv4.tcp_mtu_probing=1" | tee -a /etc/sysctl.d/99-sysctl.conf

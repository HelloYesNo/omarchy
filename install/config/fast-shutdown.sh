mkdir -p /etc/systemd/system.conf.d

cat <<EOF | tee /etc/systemd/system.conf.d/10-faster-shutdown.conf
[Manager]
DefaultTimeoutStopSec=5s
EOF
systemctl daemon-reload

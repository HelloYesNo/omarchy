#!/bin/bash

# Post‑install configuration for Fedora (dnf)

if [[ ${DISTRO_ID:-} != "fedora" ]]; then
  exit 0
fi

echo "Configuring dnf settings..."

# Enable fastestmirror and keepcache
sudo tee /etc/dnf/dnf.conf > /dev/null << 'EOF'
[main]
gpgcheck=True
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
fastestmirror=True
keepcache=True
EOF

# Optional: add additional repositories (e.g., RPM Fusion already added in preflight)
# Enable updates-testing if needed
# sudo dnf config-manager --set-enabled updates-testing

echo "dnf configuration applied."

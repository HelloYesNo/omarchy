# Install all base packages
mapfile -t packages < <(grep -v '^#' "$OMARCHY_INSTALL/omarchy-base.packages" | grep -v '^$')
dnf5 install -y --skip-unavailable --skip-broken --allowerasing "${packages[@]}"

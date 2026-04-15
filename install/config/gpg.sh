# Setup GPG configuration with multiple keyservers for better reliability
sudo mkdir -p /etc/gnupg
if [[ -f $OMARCHY_PATH/default/gpg/dirmngr.conf ]]; then
  sudo cp "$OMARCHY_PATH/default/gpg/dirmngr.conf" /etc/gnupg/
  sudo chmod 644 /etc/gnupg/dirmngr.conf
  sudo gpgconf --kill dirmngr || true
  sudo gpgconf --launch dirmngr || true
else
  echo "Warning: gpg/dirmngr.conf not found at $OMARCHY_PATH/default/gpg/dirmngr.conf"
fi

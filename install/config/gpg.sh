# Setup GPG configuration with multiple keyservers for better reliability
mkdir -p /etc/gnupg
cp /.local/share/omarchy/default/gpg/dirmngr.conf /etc/gnupg/
chmod 644 /etc/gnupg/dirmngr.conf
gpgconf --kill dirmngr || true
gpgconf --launch dirmngr || true

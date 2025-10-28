# Configure pacman
cp -f $HOME/.local/share/omarchy/default/pacman/pacman.conf /etc/pacman.conf
cp -f $HOME/.local/share/omarchy/default/pacman/mirrorlist /etc/pacman.d/mirrorlist

if lspci -nn | grep -q "106b:180[12]"; then
  cat <<EOF | tee -a /etc/pacman.conf >/dev/null

[arch-mact2]
Server = https://github.com/NoaHimesaka1873/arch-mact2-mirror/releases/download/release
SigLevel = Never
EOF
fi

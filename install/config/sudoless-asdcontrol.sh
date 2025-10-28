# Setup sudo-less controls for controlling brightness on Apple Displays
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/asdcontrol" | tee /etc/sudoers.d/asdcontrol
chmod 440 /etc/sudoers.d/asdcontrol

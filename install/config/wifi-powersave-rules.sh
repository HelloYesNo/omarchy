if omarchy-battery-present; then
  # Ensure the wifi-powersave script is available in the expected location
  mkdir -p "$HOME/.local/share/omarchy/bin"
  if [[ -f $OMARCHY_PATH/bin/omarchy-wifi-powersave ]]; then
    cp "$OMARCHY_PATH/bin/omarchy-wifi-powersave" "$HOME/.local/share/omarchy/bin/"
    chmod +x "$HOME/.local/share/omarchy/bin/omarchy-wifi-powersave"
  else
    echo "Warning: omarchy-wifi-powersave not found at $OMARCHY_PATH/bin/omarchy-wifi-powersave"
  fi

  cat <<EOF | sudo tee "/etc/udev/rules.d/99-wifi-powersave.rules"
SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="$HOME/.local/share/omarchy/bin/omarchy-wifi-powersave on"
SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="$HOME/.local/share/omarchy/bin/omarchy-wifi-powersave off"
EOF

  sudo udevadm control --reload
  sudo udevadm trigger --subsystem-match=power_supply
fi

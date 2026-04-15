stop_install_log

echo_in_style() {
  if command -v tte &>/dev/null; then
    echo "$1" | tte --canvas-width 0 --anchor-text c --frame-rate 640 print
  else
    echo "$1"
  fi
}

clear
echo
if [[ -f $OMARCHY_PATH/logo.txt ]]; then
  if command -v tte &>/dev/null; then
    tte -i "$OMARCHY_PATH/logo.txt" --canvas-width 0 --anchor-text c --frame-rate 920 laseretch
  else
    cat "$OMARCHY_PATH/logo.txt"
  fi
else
  echo "Warning: logo.txt not found at $OMARCHY_PATH/logo.txt"
fi
echo

# Display installation time if available
if [[ -f $OMARCHY_INSTALL_LOG_FILE ]] && grep -q "Total:" "$OMARCHY_INSTALL_LOG_FILE" 2>/dev/null; then
  echo
  TOTAL_TIME=$(tail -n 20 "$OMARCHY_INSTALL_LOG_FILE" | grep "^Total:" | sed 's/^Total:[[:space:]]*//')
  if [[ -n $TOTAL_TIME ]]; then
    echo_in_style "Installed in $TOTAL_TIME"
  fi
else
  echo_in_style "Finished installing"
fi

if sudo test -f /etc/sudoers.d/99-omarchy-installer; then
  sudo rm -f /etc/sudoers.d/99-omarchy-installer &>/dev/null
fi

# Exit gracefully if user chooses not to reboot
if gum confirm --show-help=false --default --affirmative "Reboot Now" --negative "" ""; then
  # Clear screen to hide any shutdown messages
  clear

  if [[ -n ${OMARCHY_CHROOT_INSTALL:-} ]]; then
    touch /var/tmp/omarchy-install-completed
    exit 0
  else
    sudo reboot 2>/dev/null
  fi
fi

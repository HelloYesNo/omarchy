#!/bin/bash

# Plymouth theme setup - only run if plymouth is installed
if ! command -v plymouth-set-default-theme &>/dev/null; then
    echo "plymouth-set-default-theme not found; skipping Plymouth theme setup."
    exit 0
fi

# Ensure the plymouth script plugin exists (required for theme switching)
if [[ ! -f /usr/lib64/plymouth/script.so ]] && [[ ! -f /usr/lib/plymouth/script.so ]]; then
    echo "plymouth script plugin not found; skipping theme setup."
    exit 0
fi

if [[ $(plymouth-set-default-theme) != "omarchy" ]]; then
  if [[ -d $OMARCHY_PATH/default/plymouth ]]; then
    sudo cp -r "$OMARCHY_PATH/default/plymouth" /usr/share/plymouth/themes/omarchy/
    sudo plymouth-set-default-theme omarchy
  else
    echo "Warning: plymouth theme directory not found at $OMARCHY_PATH/default/plymouth"
  fi
fi

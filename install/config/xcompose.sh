# Set default XCompose that is triggered with CapsLock

# Ensure the default xcompose file is available in the expected location
mkdir -p ~/.local/share/omarchy/default
if [[ -f $OMARCHY_PATH/default/xcompose ]]; then
  cp "$OMARCHY_PATH/default/xcompose" ~/.local/share/omarchy/default/
else
  echo "Warning: default/xcompose not found at $OMARCHY_PATH/default/xcompose"
fi

tee ~/.XCompose >/dev/null <<EOF
# Run omarchy-restart-xcompose to apply changes

# Include fast emoji access
include "%H/.local/share/omarchy/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$OMARCHY_USER_NAME"
<Multi_key> <space> <e> : "$OMARCHY_USER_EMAIL"
EOF

# Copy over Omarchy configs
mkdir -p ~/.config
if [[ -d $OMARCHY_PATH/config ]]; then
  cp -R "$OMARCHY_PATH"/config/* ~/.config/
else
  echo "Warning: config directory not found at $OMARCHY_PATH/config"
fi

# Use default bashrc from Omarchy
if [[ -f $OMARCHY_PATH/default/bashrc ]]; then
  cp "$OMARCHY_PATH/default/bashrc" ~/.bashrc
else
  echo "Warning: default bashrc not found at $OMARCHY_PATH/default/bashrc"
fi

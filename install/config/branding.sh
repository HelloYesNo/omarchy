# Allow the user to change the branding for fastfetch and screensaver
mkdir -p ~/.config/omarchy/branding
if [[ -f $OMARCHY_PATH/icon.txt ]]; then
  cp "$OMARCHY_PATH/icon.txt" ~/.config/omarchy/branding/about.txt
else
  echo "Warning: icon.txt not found at $OMARCHY_PATH/icon.txt"
fi
if [[ -f $OMARCHY_PATH/logo.txt ]]; then
  cp "$OMARCHY_PATH/logo.txt" ~/.config/omarchy/branding/screensaver.txt
else
  echo "Warning: logo.txt not found at $OMARCHY_PATH/logo.txt"
fi

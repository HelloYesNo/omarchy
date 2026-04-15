# Omarchy logo in a font for Waybar use
mkdir -p ~/.local/share/fonts
if [[ -f $OMARCHY_PATH/config/omarchy.ttf ]]; then
  cp "$OMARCHY_PATH/config/omarchy.ttf" ~/.local/share/fonts/
else
  echo "Warning: omarchy.ttf not found at $OMARCHY_PATH/config/omarchy.ttf"
fi
fc-cache

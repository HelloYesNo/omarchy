# Copy all bundled icons to the applications/icons directory
ICON_DIR="$HOME/.local/share/applications/icons"
mkdir -p "$ICON_DIR"
if [[ -d $OMARCHY_PATH/applications/icons ]]; then
  cp "$OMARCHY_PATH"/applications/icons/*.png "$ICON_DIR/" 2>/dev/null || true
else
  echo "Warning: Icons directory not found at $OMARCHY_PATH/applications/icons"
fi

# Includes lazyvim and the themes
if command -v omarchy-nvim-setup &>/dev/null; then
  omarchy-nvim-setup
else
  echo "omarchy-nvim-setup not found; skipping Neovim configuration."
fi

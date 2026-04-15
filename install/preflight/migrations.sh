OMARCHY_MIGRATIONS_STATE_PATH=~/.local/state/omarchy/migrations
mkdir -p $OMARCHY_MIGRATIONS_STATE_PATH

if [[ -d $OMARCHY_PATH/migrations ]]; then
  for file in "$OMARCHY_PATH"/migrations/*.sh; do
    touch "$OMARCHY_MIGRATIONS_STATE_PATH/$(basename "$file")" 2>/dev/null || true
  done
else
  echo "Warning: migrations directory not found at $OMARCHY_PATH/migrations"
fi

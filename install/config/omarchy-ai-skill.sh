#!/bin/bash
# Place in ~/.claude/skills since all tools populate from there as well as their own sources
SKILL_DIR="$HOME/.claude/skills"
mkdir -p "$SKILL_DIR"

SOURCE="$OMARCHY_PATH/default/omarchy-skill"
if [[ ! -d "$SOURCE" ]]; then
    echo "Omarchy skill source not found at $SOURCE; skipping."
    exit 0
fi

if [[ -L "$SKILL_DIR/omarchy" ]] || [[ -e "$SKILL_DIR/omarchy" ]]; then
    echo "Omarchy skill already present in $SKILL_DIR; skipping."
    exit 0
fi

ln -s "$SOURCE" "$SKILL_DIR/omarchy"

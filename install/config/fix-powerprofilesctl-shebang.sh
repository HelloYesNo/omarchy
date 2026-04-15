#!/bin/bash
# Ensure we use system python3 and not mise's python3

if [[ ! -f /usr/bin/powerprofilesctl ]]; then
    echo "powerprofilesctl not found; skipping shebang fix."
    exit 0
fi

sudo sed -i '/env python3/ c\#!/bin/python3' /usr/bin/powerprofilesctl

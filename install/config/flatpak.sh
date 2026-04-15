#!/bin/bash

# Install Zen browser via flatpak (Flathub)
# This script runs after flatpak package is installed.

if command -v flatpak >/dev/null 2>&1; then
    echo "Setting up Flathub remote and installing Zen browser..."

    # Add Flathub remote if not already present
    if ! flatpak remotes --columns=name | grep -q "^flathub$"; then
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

    # Install Zen browser if not already installed
    if ! flatpak list --columns=application | grep -q "app.zen_browser.zen"; then
        flatpak install -y flathub app.zen_browser.zen
    else
        echo "Zen browser already installed via flatpak."
    fi
else
    echo "flatpak command not found. Skipping Zen browser installation."
fi
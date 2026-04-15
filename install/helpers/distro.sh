#!/bin/bash

# Detect Linux distribution and set package manager variables
# This script must be sourced, not executed.

if [[ -f /etc/os-release ]]; then
  source /etc/os-release
else
  echo "ERROR: /etc/os-release not found. Cannot detect distribution." >&2
  exit 1
fi

# Determine DISTRO_ID based on ID and ID_LIKE
case "$ID" in
  arch)
    DISTRO_ID="arch"
    ;;
  fedora)
    DISTRO_ID="fedora"
    ;;
  *)
    # Check ID_LIKE for derivatives
    if [[ "$ID_LIKE" =~ "arch" ]]; then
      DISTRO_ID="arch"
    elif [[ "$ID_LIKE" =~ "fedora" ]]; then
      DISTRO_ID="fedora"
    else
      DISTRO_ID="$ID"
    fi
    ;;
esac

# Set package manager variables
case "$DISTRO_ID" in
  arch)
    PKG_MANAGER="pacman"
    PKG_INSTALL="pacman -S --noconfirm --needed"
    PKG_QUERY="pacman -Q"
    PKG_REFRESH="pacman -Sy"
    ;;
  fedora)
    PKG_MANAGER="dnf"
    PKG_INSTALL="dnf install -y --skip-broken --setopt=strict=0"
    PKG_QUERY="rpm -q"
    PKG_REFRESH="dnf check-update"
    ;;
  *)
    # Default to dnf for rpm-based, apt for deb-based, etc.
    # This is a fallback; we may not support other distros yet.
    if command -v dnf &>/dev/null; then
      PKG_MANAGER="dnf"
      PKG_INSTALL="dnf install -y"
      PKG_QUERY="rpm -q"
      PKG_REFRESH="dnf check-update"
    elif command -v apt &>/dev/null; then
      PKG_MANAGER="apt"
      PKG_INSTALL="apt install -y"
      PKG_QUERY="dpkg -l"
      PKG_REFRESH="apt update"
    else
      echo "ERROR: Unsupported distribution ($DISTRO_ID) and no known package manager found." >&2
      exit 1
    fi
    ;;
esac

# Export variables for use in other scripts
export DISTRO_ID
export PKG_MANAGER
export PKG_INSTALL
export PKG_QUERY
export PKG_REFRESH

#!/bin/bash

# Pre‑flight steps for Fedora (dnf‑based systems)

if [[ ${DISTRO_ID:-} != "fedora" ]]; then
  # This script is only for Fedora
  exit 0
fi

if [[ -n ${OMARCHY_ONLINE_INSTALL:-} ]]; then
  echo "Setting up Fedora repositories and updating system..."

  # Install dnf plugins for managing repositories
  sudo dnf install -y dnf-plugins-core

  # Add RPM Fusion free & nonfree (if not already present)
  if ! dnf repolist | grep -q rpmfusion; then
    sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf config-manager --set-enabled rpmfusion-free rpmfusion-nonfree
  fi

  # Add COPR repository for Walker & Elephant
  sudo dnf copr enable -y errornointernet/walker
  sudo dnf copr enable -y erikreider/swayosd

  # Add COPR repository for Hyprland (architecture‑specific)
  if [[ $(uname -m) == "x86_64" ]]; then
    sudo dnf copr enable -y solopasha/hyprland
    echo "Enabled solopasha/hyprland COPR for x86_64."
  elif [[ $(uname -m) == "aarch64" ]]; then
    sudo dnf copr enable -y technochip/Hyprland-aarch64
    echo "Enabled technochip/Hyprland-aarch64 COPR for aarch64."
  else
    echo "Skipping hyprland COPR on $(uname -m) (unsupported architecture)."
  fi

  # Update the system
  sudo dnf update -y

  # Install build tools (equivalent to Arch's base-devel)
  sudo dnf groupinstall -y "Development Tools"
  sudo dnf install -y kernel-devel

  # Install other essential packages for Omarchy
  sudo dnf install -y git curl wget

  echo "Fedora pre‑flight steps completed."
fi

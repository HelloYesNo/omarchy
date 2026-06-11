#!/bin/bash

# Extra package installation for Fedora (post‑base packages)

if [[ ${DISTRO_ID:-} != "fedora" ]]; then
  exit 0
fi

echo "Installing additional packages for Fedora..."

# GitHub CLI
if ! rpm -q github-cli 2>/dev/null; then
  echo "Adding GitHub CLI repository..."
  sudo rpm --import https://cli.github.com/packages/githubcli-archive-keyring.gpg
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install -y gh
else
  echo "GitHub CLI already installed."
fi

# Signal Desktop via flatpak (only on x86_64; ARM not available on Flathub)
if command -v flatpak >/dev/null 2>&1; then
  if [[ $(uname -m) == "x86_64" ]]; then
    if ! flatpak list --columns=application | grep -q org.signal.Signal; then
      echo "Installing Signal Desktop via flatpak..."
      flatpak install -y flathub org.signal.Signal
    else
      echo "Signal Desktop already installed via flatpak."
    fi
  else
    echo "Signal Desktop not available on $(uname -m) via Flathub; skipping."
  fi
else
  echo "flatpak not found; skipping Signal Desktop."
fi

# Starship via cargo (requires cargo installed)
if command -v cargo >/dev/null 2>&1; then
  if ! command -v starship >/dev/null 2>&1; then
    echo "Installing starship via cargo..."
    cargo install starship --locked
    # Ensure ~/.cargo/bin is in PATH for subsequent steps
    export PATH="$HOME/.cargo/bin:$PATH"
    # Symlink to ~/.local/bin for consistency
    mkdir -p ~/.local/bin
    ln -sf ~/.cargo/bin/starship ~/.local/bin/starship 2>/dev/null || true
  else
    echo "starship already installed."
  fi
else
  echo "cargo not found; install cargo package first."
  # Try installing cargo via dnf (if script is running with sudo)
  if command -v sudo >/dev/null 2>&1; then
    echo "Attempting to install cargo..."
    sudo dnf install -y cargo
    if command -v cargo >/dev/null 2>&1; then
      echo "Installing starship via cargo..."
      cargo install starship --locked
      export PATH="$HOME/.cargo/bin:$PATH"
      ln -sf ~/.cargo/bin/starship ~/.local/bin/starship 2>/dev/null || true
    else
      echo "Failed to install cargo; starship not installed."
    fi
  fi
fi

echo "Fedora extra packages done."

# Install Rust-based TUIs via cargo (not in dnf repos)
echo "Installing Omarchy TUIs via cargo..."

if command -v cargo >/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"

  if ! command -v cargo-install-update >/dev/null 2>&1; then
    echo "Installing cargo-update (for updating cargo packages)..."
    cargo install cargo-update --locked
  else
    echo "cargo-update already installed."
  fi

  if ! command -v impala >/dev/null 2>&1; then
    echo "Installing impala (wifi TUI)..."
    cargo install impala --locked
  else
    echo "impala already installed."
  fi
  mkdir -p ~/.local/bin
  ln -sf ~/.cargo/bin/impala ~/.local/bin/impala 2>/dev/null || true

  if ! command -v bluetui >/dev/null 2>&1; then
    echo "Installing bluetui (bluetooth TUI)..."
    cargo install bluetui --locked
  else
    echo "bluetui already installed."
  fi
  ln -sf ~/.cargo/bin/bluetui ~/.local/bin/bluetui 2>/dev/null || true

  if ! command -v aether >/dev/null 2>&1; then
    echo "Installing aether (bluetooth)..."
    cargo install aether --locked
  else
    echo "aether already installed."
  fi
  ln -sf ~/.cargo/bin/aether ~/.local/bin/aether 2>/dev/null || true
else
  echo "cargo not found; skipping TUI installs."
fi

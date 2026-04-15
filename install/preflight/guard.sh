abort() {
  echo -e "\e[31mOmarchy install requires: $1\e[0m"
  echo
  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

# Determine distribution (should already be set via helpers/distro.sh)
if [[ -z ${DISTRO_ID:-} ]]; then
  # Fallback detection
  if [[ -f /etc/os-release ]]; then
    source /etc/os-release
    if [[ "$ID" == "arch" || "$ID_LIKE" =~ "arch" ]]; then
      DISTRO_ID="arch"
    elif [[ "$ID" == "fedora" || "$ID_LIKE" =~ "fedora" ]]; then
      DISTRO_ID="fedora"
    else
      abort "Arch or Fedora Linux"
    fi
  else
    abort "Arch or Fedora Linux"
  fi
fi

# Must be Arch or Fedora
if [[ $DISTRO_ID != "arch" && $DISTRO_ID != "fedora" ]]; then
  abort "Arch or Fedora Linux"
fi

# For Arch, must be vanilla (no derivatives)
if [[ $DISTRO_ID == "arch" ]]; then
  if [[ ! -f /etc/arch-release ]]; then
    abort "Vanilla Arch"
  fi
  for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
    if [[ -f $marker ]]; then
      abort "Vanilla Arch"
    fi
  done
fi

# Must not be running as root
if (( EUID == 0 )); then
  abort "Running as root (not user)"
fi

# Must be x86 only to fully work (skip for Fedora)
if [[ $DISTRO_ID != "fedora" ]]; then
  if [[ $(uname -m) != "x86_64" ]]; then
    abort "x86_64 CPU"
  fi
fi

# Must have secure boot disabled
if bootctl status 2>/dev/null | grep -q 'Secure Boot: enabled'; then
  abort "Secure Boot disabled"
fi

# Must not have Gnome or KDE already installed (only check on Arch)
if [[ $DISTRO_ID == "arch" ]]; then
  if pacman -Qe gnome-shell &>/dev/null || pacman -Qe plasma-desktop &>/dev/null; then
    abort "Fresh + Vanilla Arch"
  fi
fi

# Must have limine installed (skip for Fedora)
if [[ $DISTRO_ID != "fedora" ]]; then
  command -v limine &>/dev/null || abort "Limine bootloader"
fi

# Must have btrfs root filesystem
[[ $(findmnt -n -o FSTYPE /) = "btrfs" ]] || abort "Btrfs root filesystem"

# Cleared all guards
echo "Guards: OK"

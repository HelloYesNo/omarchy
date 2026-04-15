show_install_menu() {
  # Load distro detection to adjust community repo label
  OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"
  if [[ -f "$OMARCHY_PATH/install/helpers/distro.sh" ]]; then
    source "$OMARCHY_PATH/install/helpers/distro.sh"
  else
    # fallback detection
    if [[ -f /etc/arch-release ]]; then
      DISTRO_ID="arch"
    elif command -v dnf &>/dev/null; then
      DISTRO_ID="fedora"
    else
      DISTRO_ID="unknown"
    fi
  fi

  case "$DISTRO_ID" in
    arch)
      community_label="AUR"
      ;;
    fedora)
      community_label="COPR"
      ;;
    *)
      community_label="Community"
      ;;
  esac

  case $(menu "Install" "󰣇  Package\n󰣇  $community_label\n󰇉  Flatpak\n  Web App\n  TUI\n  Service\n  Style\n󰵮  Development\n  Editor\n  Terminal\n󱚤  AI\n󰍲  Windows\n  Gaming") in
  *Package*) terminal omarchy-pkg-install ;;
  *AUR*|*COPR*|*Community*) terminal omarchy-pkg-aur-install ;;
  *Flatpak*) present_terminal omarchy-pkg-flatpak-install ;;
  *Web*) present_terminal omarchy-webapp-install ;;
  *TUI*) present_terminal omarchy-tui-install ;;
  *Service*) show_install_service_menu ;;
  *Style*) show_install_style_menu ;;
  *Development*) show_install_development_menu ;;
  *Editor*) show_install_editor_menu ;;
  *Terminal*) show_install_terminal_menu ;;
  *AI*) show_install_ai_menu ;;
  *Windows*) present_terminal "omarchy-windows-vm install" ;;
  *Gaming*) show_install_gaming_menu ;;
  *) show_main_menu ;;
  esac
}
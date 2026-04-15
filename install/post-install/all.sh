run_logged $OMARCHY_INSTALL/post-install/hibernation.sh

# Distribution‑specific package manager configuration
if [[ ${DISTRO_ID:-} == "fedora" ]]; then
  run_logged $OMARCHY_INSTALL/post-install/dnf.sh
else
  run_logged $OMARCHY_INSTALL/post-install/pacman.sh
fi

source $OMARCHY_INSTALL/post-install/allow-reboot.sh
source $OMARCHY_INSTALL/post-install/finished.sh

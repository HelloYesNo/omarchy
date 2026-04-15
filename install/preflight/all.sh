source $OMARCHY_INSTALL/preflight/guard.sh
source $OMARCHY_INSTALL/preflight/begin.sh
run_logged $OMARCHY_INSTALL/preflight/show-env.sh

# Distribution‑specific repository setup
if [[ ${DISTRO_ID:-} == "fedora" ]]; then
  run_logged $OMARCHY_INSTALL/preflight/dnf.sh
else
  run_logged $OMARCHY_INSTALL/preflight/pacman.sh
fi

run_logged $OMARCHY_INSTALL/preflight/migrations.sh
run_logged $OMARCHY_INSTALL/preflight/first-run-mode.sh
run_logged $OMARCHY_INSTALL/preflight/disable-mkinitcpio.sh

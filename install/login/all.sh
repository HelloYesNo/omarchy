run_logged $OMARCHY_INSTALL/login/plymouth.sh
run_logged $OMARCHY_INSTALL/login/default-keyring.sh
run_logged $OMARCHY_INSTALL/login/sddm.sh

if [[ ${DISTRO_ID:-} == "arch" ]]; then
  run_logged $OMARCHY_INSTALL/login/limine-snapper.sh
fi

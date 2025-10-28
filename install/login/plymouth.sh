if [ "$(plymouth-set-default-theme)" != "omarchy" ]; then
  cp -r "/.local/share/omarchy/default/plymouth" /usr/share/plymouth/themes/omarchy/
  plymouth-set-default-theme omarchy
fi

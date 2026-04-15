# Install all base packages
if [[ ${DISTRO_ID:-} == "fedora" ]]; then
  PACKAGE_FILE="$OMARCHY_INSTALL/omarchy-base.fedora.packages"
else
  PACKAGE_FILE="$OMARCHY_INSTALL/omarchy-base.packages"
fi

if [[ ! -f $PACKAGE_FILE ]]; then
  echo "ERROR: Package list $PACKAGE_FILE not found." >&2
  exit 1
fi

mapfile -t packages < <(grep -v '^#' "$PACKAGE_FILE" | grep -v '^$')

# Hyprland packages are now available via architecture‑specific COPRs
# (solopasha/hyprland for x86_64, technochip/Hyprland-aarch64 for aarch64)
# No filtering needed; missing packages will be skipped with --skip‑broken.

omarchy-pkg-add "${packages[@]}"

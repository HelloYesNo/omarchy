#!/bin/bash

# This hook is Arch-specific (kernel-modules-hook package)
if [[ ${DISTRO_ID:-} != "arch" ]]; then
    echo "Skipping kernel-modules-hook (not needed on $DISTRO_ID)."
    exit 0
fi

chrootable_systemctl_enable linux-modules-cleanup.service

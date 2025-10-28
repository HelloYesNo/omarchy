#!/bin/bash

# Create pacman hook to restart walker after updates
mkdir -p /etc/pacman.d/hooks
tee /etc/pacman.d/hooks/walker-restart.hook > /dev/null << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = walker
Target = walker-debug
Target = elephant*

[Action]
Description = Restarting Walker services after system update
When = PostTransaction
Exec = $OMARCHY_PATH/bin/omarchy-restart-walker
EOF

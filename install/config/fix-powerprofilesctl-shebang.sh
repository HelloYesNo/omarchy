# Ensure we use system python3 and not mise's python3
sed -i '/env python3/ c\#!/bin/python3' /usr/bin/powerprofilesctl

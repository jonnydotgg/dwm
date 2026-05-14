#!/bin/bash

# Step 1: Temporarily switch mod key to Ctrl
echo "[*] Patching mod key to ControlMask..."
#sed -i.bak 's/#define MODKEY Mod1Mask/#define MODKEY ControlMask/' config.def.h
sed -i.bak 's/^#define MODKEY.*/#define MODKEY ControlMask/' config.def.h

# Step 2: Build
echo "[*] Cleaning and building dwm..."
make clean
make

# Step 3: Run Xephyr and launch dwm in it
Xephyr -br -ac -noreset -screen 1280x720 :1 &
sleep 1
DISPLAY=:1 /home/brownjo/git/suckless/st/st &
DISPLAY=:1 ./dwm

# Step 4: Restore mod key after test
echo "[*] Restoring original mod key..."
mv config.def.h.bak config.def.h
rm config.h

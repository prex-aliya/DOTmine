#!/bin/sh
# https://github.com/DabideBoi/dwm-installer
# Thanks for the help! Check theme out!

# Install dependencies
# sudo dnf install git make gcc libXft-devel libX11-devel libXinerama-devel

# Set up XDG directories
xdg_config_home=${XDG_CONFIG_HOME:-$HOME/.config}
xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

# Set Variables
app="https://github.com/prex-aliya/"
wm="DWMmine"
term="STmine"
status="DMENUmine"

# Root Script
if [ "$EUID" -ne 0 ]; then
    root=false
    echo "running with sudo"
else
    root=true
    echo "running as if root"
fi



mkdir -p "$xdg_data_home/suckless"
cd "$xdg_data_home/suckless"

# Clone and install dwm, st, and dmenu
for end in $wm $term $status; do
    git clone "$app$end"
    cd "$end"
    make
    if $root = true; then
        make clean install
    else
        sudo make clean install
    fi
    cd ..
done

# Create DWM session file in XDG directory
echo "Creating DWM session"
echo "[Desktop Entry]
Encoding=UTF-8
Name=DWM
Exec=dwm-setup
Icon=dwm
Type=XSession" | sudo tee "/usr/share/xsessions/dwm.desktop"

# Create dwm-setup config file in /usr/local/bin
echo "exec dwm" | sudo tee /usr/local/bin/dwm-setup
sudo chmod +x /usr/local/bin/dwm-setup

echo "Install now complete. You can now logout and change your DE/WM."

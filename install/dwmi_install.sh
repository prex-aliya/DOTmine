# https://github.com/DabideBoi/dwm-installer
# Thanks for the help! Check theme out!
#!/bin/sh

# Prompt for password at the start
echo "Running as if Root"

# Install dependencies
# sudo dnf install git make gcc libXft-devel libX11-devel libXinerama-devel

# Set up XDG directories
xdg_config_home=${XDG_CONFIG_HOME:-$HOME/.config}
xdg_data_home=${XDG_DATA_HOME:-$HOME/.local/share}

app="https://github.com/prex-aliya/DWMmine"
wm=""
term=""
status=""

# Set 

mkdir -p "$xdg_data_home/suckless"
cd "$xdg_data_home/suckless"

# Clone and install dwm, st, and dmenu
for app in $wm $term $status; do
    git clone "https://git.suckless.org/$app"
    cd "$app"
    make
    sudo make clean install
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

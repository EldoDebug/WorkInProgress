#!/usr/bin/env bash
echo "Welcome to ???????????? Installer"

USERNAME=$(whoami)

# Update packages
echo "Start updating packages"
sudo pacman -Syu

# Install git if it does not exist
if ! command -v git >/dev/null 2>&1;then
    sudo pacman -S --noconfirm git
fi

# Install yay if it does not exist
if ! command -v yay >/dev/null 2>&1;then
    git clone https://aur.archlinux.org/yay-bin.git yay-bin
    cd yay-bin
    makepkg -si --noconfirm
    cd ..
    rm -rf yay-bin
fi

# Download the required dependencies
echo "Start downloading required dependencies"

# Core
yay -S --noconfirm hyprland hyprlock xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs \
                    xdg-desktop-portal-hyprland adw-gtk3 aylurs-gtk-shell libdbusmenu-gtk3 

# Authentication
yay -S --noconfirm polkit-gnome gnome-keyring

# Applications
yay -S --noconfirm gnome-control-center resources nautilus vesktop-bin alacritty visual-studio-code-bin firefox

# Cli tools
yay -S --noconfirm ffmpeg jq grim slurp wl-clipboard libnotify hyprpicker dart-sass yad bc \
                    cliphist fish fastfetch nano python-pywal python-materialyoucolor-git swww

# Extensions
yay -S --noconfirm nautilus-open-any-terminal

# Fonts
yay -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji consolas-font \
                    ttf-material-symbols-variable-git ttf-roboto

# Copy config file to .config
echo "Start copying the config file to .config"
cp -R .config ~/

# Install sddm
echo "Start sddm installation"

yay -S --noconfirm sddm
systemctl enable sddm.service 
sudo mkdir /etc/sddm.conf.d

# Set Auto Login
echo "[Autologin]" > ./autologin.conf
echo "User="$USERNAME >> ./autologin.conf
echo "Session=hyprland" >> ./autologin.conf
sudo mv ./autologin.conf /etc/sddm.conf.d/autologin.conf

# Running required commands after installation
echo "Running required commands after installation"

# Set default terminal to alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

echo "Successful installation!"
echo "You need to reboot your system"
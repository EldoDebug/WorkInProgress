#!/usr/bin/env bash
echo "Welcome to Voidarium Installer"

USERNAME=$(whoami)

sudo pacman -Syu

if ! command -v git >/dev/null 2>&1;then
    echo "git does not exist!"
    echo "Installing git..."
    sudo pacman -S --noconfirm git
fi

if ! command -v yay >/dev/null 2>&1;then
    echo "yay does not exist!"
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay-bin.git yay-bin
    cd yay-bin
    makepkg -si --noconfirm
    cd ..
    rm -rf yay-bin
fi

echo "Downloading the required package..."

yay -S --noconfirm hyprland xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs \
    xdg-desktop-portal-hyprland gnome-control-center polkit-gnome \
    gnome-keyring \
    ffmpeg resources swww matugen-bin adw-gtk3 aylurs-gtk-shell libdbusmenu-gtk3 \
    jq grim slurp wl-clipboard libnotify hyprpicker dart-sass yad \
    bc hyprlock cliphist fish fastfetch python-pywal \
    nautilus nautilus-open-any-terminal vesktop-bin \
    alacritty nano \
    noto-fonts noto-fonts-cjk noto-fonts-emoji consolas-font ttf-material-symbols-variable-git ttf-roboto \
    visual-studio-code-bin firefox

echo "Copying .config folder..."
cp -R .config ~/

echo "Installing sddm..."
yay -S --noconfirm sddm
systemctl enable sddm.service 
sudo mkdir /etc/sddm.conf.d
echo "[Autologin]" > ./autologin.conf
echo "User="$USERNAME >> ./autologin.conf
echo "Session=hyprland" >> ./autologin.conf
sudo mv ./autologin.conf /etc/sddm.conf.d/autologin.conf

echo "Running required commands after installation"
# Set default terminal to alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
# Apc Customize UI++
sudo chown -R $(whoami) /opt/visual-studio-code

echo "Successful installation!"
echo "You need to reboot your system"
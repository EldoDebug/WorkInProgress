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

yay -S --noconfirm hyprland xdg-desktop-portal xdg-desktop-portal-gtk \
    xdg-desktop-portal-hyprland gnome-control-center polkit-gnome \
    gnome-keyring \
    ffmpeg resources swww matugen-bin adw-gtk3 aylurs-gtk-shell libdbusmenu-gtk3 \
    jq grim slurp wl-clipboard libnotify hyprpicker dart-sass yad \
    bc hyprlock cliphist fish fastfetch python-pywal \
    nautilus nautilus-open-any-terminal vesktop-bin \
    alacritty nano \
    noto-fonts noto-fonts-cjk noto-fonts-emoji consolas-font ttf-material-symbols-variable-git

echo "Copying .config folder..."
cp -R .config ~/

read -n1 -rep "Do you want to install sddm? (y/n)" SDDM
if [[ $SDDM == "Y" || $SDDM == "y" ]]; then
    yay -S --noconfirm sddm
    systemctl enable sddm.service 

    read -n1 -rep "Do you want to make it AutoLogin?" AUTOLOGIN 
    if [[ $AUTOLOGIN == "Y" || $AUTOLOGIN == "y" ]]; then
        sudo mkdir /etc/sddm.conf.d
        sudo echo "[Autologin]" > /etc/sddm.conf.d/autologin.conf
        sudo echo "User="$USERNAME >> /etc/sddm.conf.d/autologin.conf
        sudo echo "Session=hyprland" >> /etc/sddm.conf.d/autologin.conf
    fi   
fi

echo "Do you want to install a transparent vscode?"
read -n1 -rep "*Installation will take some time (y/n)" CODE

if [[ $CODE == "Y" || $CODE == "y" ]]; then
    yay -S --noconfirm code-translucent
fi

echo "Running required commands after installation"
# Set default terminal to alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

echo "Successful installation!"
echo "You need to reboot your system"
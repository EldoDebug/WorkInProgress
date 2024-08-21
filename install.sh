#!/usr/bin/env bash
echo "Welcome to EldoDebug's Gruvbox-Material Theme Installer"

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

yay -S --noconfirm hyprland hyprlock xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs \
    xdg-desktop-portal-hyprland gnome-control-center polkit-gnome \
    gnome-keyring gradience \
    ffmpeg resources swww adw-gtk3 aylurs-gtk-shell libdbusmenu-gtk3 \
    jq grim slurp wl-clipboard libnotify hyprpicker dart-sass yad \
    bc cliphist fish fastfetch \
    nautilus nautilus-open-any-terminal vesktop-bin \
    alacritty nano \
    noto-fonts noto-fonts-cjk noto-fonts-emoji consolas-font ttf-material-symbols-variable-git ttf-roboto \
    visual-studio-code-bin firefox spotify-adblock spicetify-cli \
    python-pywal python-materialyoucolor-git

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

# Set Spotify Theme
#sudo chmod a+wr /opt/spotify
#sudo chmod a+wr /opt/spotify/Apps -R
#spicetify config current_theme Dribbblish color_scheme gruvbox-material-dark
#spicetify config inject_css 0 replace_colors 1 overwrite_assets 1 inject_theme_js 1
#spicetify backup apply

# Set default terminal to alacritty
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty

<<<<<<< HEAD
=======
# Install vscode theme
code --install-extension sainnhe.gruvbox-material
code --install-extension JonathanHarty.gruvbox-material-icon-theme

# Apply theme
$(~/.config/ags/scripts/theme.sh dark)

>>>>>>> 4dd81d52c69f016376b3b439bfd980f8d6e1f2b3
echo "Successful installation!"
echo "You need to reboot your system"
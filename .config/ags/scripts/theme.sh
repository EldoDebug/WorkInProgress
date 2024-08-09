#!/usr/bin/env bash
if [ "$1" == '' ]; then
    echo "Please type dark or light"
    exit 1
fi

if [ "$1" == 'dark' ]; then

    # Set gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    
    # Copy ags colors
    cp -f ~/.config/ags/scripts/theme/ags-dark.scss ~/.config/ags/styles/colors.scss

    # Change vscode theme
    $(cp ~/'.config/Code/User/settings.json' ~/'.cache/vscode-settings.json')
    $(jq -s '.[0]* .[1]' ~/'.cache/vscode-settings.json' ~/'.config/ags/scripts/theme/vscode-dark.json' > ~/'.config/Code/User/settings.json')

    # Change wal theme
    wal --theme base16-gruvbox-medium -q

    # Set Gtk theme
    cp -f ~/.config/ags/scripts/theme/gtk-dark.css ~/.config/gtk-4.0/colors.css
    cp -f ~/.config/ags/scripts/theme/gtk-dark.css ~/.config/gtk-3.0/colors.css
elif [ "$1" == 'light' ]; then

    # Set gtk theme
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'

    # Copy ags colors
    cp -f ~/.config/ags/scripts/theme/ags-light.scss ~/.config/ags/styles/colors.scss

    # Change vscode theme
    $(cp ~/'.config/Code/User/settings.json' ~/'.cache/vscode-settings.json')
    $(jq -s '.[0]* .[1]' ~/'.cache/vscode-settings.json' ~/'.config/ags/scripts/theme/vscode-light.json' > ~/'.config/Code/User/settings.json')

    # Change wal theme
    wal --theme base16-gruvbox-medium -l -q

    # Set Gtk theme
    cp -f ~/.config/ags/scripts/theme/gtk-light.css ~/.config/gtk-4.0/colors.css
    cp -f ~/.config/ags/scripts/theme/gtk-light.css ~/.config/gtk-3.0/colors.css
fi

$(ags -q; ags)
&(nautilus -q)
#!/usr/bin/env bash
switch() {
	imgpath=$1
	read scale screenx screeny screensizey < <(hyprctl monitors -j | jq '.[] | select(.focused) | .scale, .x, .y, .height' | xargs)
	cursorposx=$(hyprctl cursorpos -j | jq '.x' 2>/dev/null) || cursorposx=960
	cursorposx=$(bc <<< "scale=0; ($cursorposx - $screenx) * $scale / 1")
	cursorposy=$(hyprctl cursorpos -j | jq '.y' 2>/dev/null) || cursorposy=540
	cursorposy=$(bc <<< "scale=0; ($cursorposy - $screeny) * $scale / 1")
	cursorposy_inverted=$((screensizey - cursorposy))

	if [ "$imgpath" == '' ]; then
		echo 'Aborted'
		exit 0
	fi
	
	# Apply wal
	$(wal --theme base16-gruvbox-medium)

	# Change Wallpaper
	swww img "$imgpath" --transition-step 100 --transition-fps 240 \
		--transition-type grow --transition-angle 30 --transition-duration 1 \
		--transition-pos "$cursorposx, $cursorposy_inverted"
}

cd "$(xdg-user-dir PICTURES)" || return 1
	switch "$(yad --width 1200 --height 800 --file --add-preview --large-preview --title='Choose wallpaper')"

# Set gtk theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Restart ags
$(ags -q; ags)

# Kill Nutilus
$(nautilus -q)

# Move Wallpaper
wallpaper=$(swww query | awk -F "image: " '{print $2}')
destination=~/.cache/voidarium/hyprlock.png
ffmpeg -y -v 0 -i $wallpaper $destination
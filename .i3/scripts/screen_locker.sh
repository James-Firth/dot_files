#!/usr/bin/env bash

icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

#Take screenshot
#scrot "$tmpbg"
#Scale it to make it blur?
#convert "$tmpbg" -scale 5% -scale 2000% "$tmpbg"
#convert "$tmpbg" -swirl 90 "$tmpbg"
## convert "$tmpbg" -sketch 2 "$tmpbg"

#overlay the icons
## convert "$tmpbg" "$icon" -gravity West -composite -matte "$tmpbg"
## convert "$tmpbg" "$icon" -gravity East -composite -matte "$tmpbg"

# Old style
#convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"

pkill -u "$USER" -USR1 dunst
i3lock -n -i "$HOME/Pictures/wallpapers/lockscreen.png" -p win -f --ignore-empty-password
pkill -u "$USER" -USR2 dunst

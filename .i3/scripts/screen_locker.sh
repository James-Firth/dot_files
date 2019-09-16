#!/usr/bin/env bash

icon="$HOME/.xlock/icon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

#Take screenshot
# scrot "$tmpbg"
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
# REMINDER: Lockscreen image MUST be a png not jpg

# i3lock --nofork --image="$HOME/Pictures/wallpapers/lockscreen.png" -c 000000 -tiling --pointer=win --show-failed-attempts --ignore-empty-password;
# i3lock --nofork -c aaaaaa --tiling --pointer=win --show-failed-attempts --ignore-empty-password

# i3lock notes:
# -t tiles

#Use screenshot
# i3lock -n -i "$tmpbg" -p win -f --ignore-empty-password

# Use tiling background
i3lock -n -i "/home/james/Pictures/wallpapers/tiling/what-the-hex-dark.png" -t -p win -f --ignore-empty-password
# pattern from https://www.toptal.com/designers/subtlepatterns/what-the-hex-dark/
pkill -u "$USER" -USR2 dunst

#!/bin/bash
xrandr --output VIRTUAL1 --off --output DP2 --off --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output eDP1 --mode 1600x900 --pos 1920x180 --rotate normal --output VGA1 --mode 1920x1080 --pos 0x0 --rotate normal

sleep 3
curr_workspace=1
for $curr_workspace in 1 2 3 4 5; do
	i3-msg move workspace $curr_workspace to output VGA1;
done;

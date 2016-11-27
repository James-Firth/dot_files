#!/bin/bash
xrandr --output VIRTUAL1 --off --output DP2 --off --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output eDP1 --mode 1600x900 --pos 0x0 --rotate normal --output VGA1 --off

curr_workspace=1
for $curr_workspace in 1 2 3 4 5 6 7 8 9 10; do
	i3-msg move workspace $curr_workspace to output eDP1;
done;

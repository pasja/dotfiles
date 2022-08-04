#!/bin/sh
xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-3 --off --output DP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-2 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-1-3 --off

xinput --set-button-map "Kensington      Kensington Expert Mouse" 1 8 3 4 5 6 7 2

#!/bin/sh
xrandr --output eDP --off --output HDMI-A-0 --off --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-3 --off --output DisplayPort-4 --off --output DisplayPort-5 --off --output DisplayPort-6 --off --output DisplayPort-7 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DisplayPort-8 --off --output DisplayPort-9 --off --output DisplayPort-10 --mode 1920x1080 --pos 1920x0 --rotate normal

xinput --set-button-map "Kensington      Kensington Expert Mouse" 1 8 3 4 5 6 7 2

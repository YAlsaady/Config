#!/bin/bash

# setxkbmap -model pc105 -layout de,ara -option grp:alt_shift_toggle
xinput set-prop SYNA32B2:00\ 06CB:CE7D\ Touchpad "libinput Natural Scrolling Enabled" 1
xinput set-prop SYNA32B2:00\ 06CB:CE7D\ Touchpad "libinput Tapping Enabled" 1
xinput set-prop SYNA32B2:00\ 06CB:CE7D\ Touchpad "libinput Accel Speed" 0.6
xinput set-prop Logitech\ M705 "libinput Accel Speed" 1
xset r rate 300 30
# xset r rate
# xinput set-prop SYNA32B2:00\ 06CB:CE7D\ Touchpad "" 1


xinput map-to-output "ELAN2514:00 04F3:2CFA" eDP1
xinput map-to-output "ELAN2514:00 04F3:2CFA Stylus Pen (0)" eDP1
xinput map-to-output "ELAN2514:00 04F3:2CFA Stylus Eraser (0)" eDP1

# xrandr --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP2 --off --output HDMI1 --off --output VIRTUAL1 --off

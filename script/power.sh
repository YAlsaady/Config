#!/bin/zsh

config=$(echo "Poweroff\nReboot\nExit\nSleep" | dmenu -i -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn DejaVuSansMonoNerdFont:bold:pixelsize=15 -b -p "Power:")

[ $config = "Poweroff" ] && systemctl poweroff && rm $HOME/.local/.screen
[ $config = "Reboot" ] && systemctl reboot && rm $HOME/.local/.screen
[ $config = "Exit" ] && pkill awesome && rm $HOME/.local/.screen
[ $config = "Sleep" ] && systemctl suspend

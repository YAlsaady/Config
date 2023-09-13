#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run udiskie
# run udiskie -C -A -t -s --terminal='alacritty -e renger' -f 'thunar' 
run nm-applet
run owncloud
run ~/.script/xinput.sh
run picom
run feh --bg-scale --randomize --no-fehbg ~/Wallpaper1/Wallpaper/*
run xfce4-power-manager
# run rm ~/.local/.screen
# run whatsapp-nativefier

# run picom -b --config  $HOME/.config/awesome/picom.conf
# run nitrogen --set-scaled --head=0 --random ~/Wallpaper1/Wallpaper
# run nitrogen --set-scaled --head=1 --random ~/Wallpaper1/Wallpaper
# run blueberry-tray
# run pamac-tray
# run numlockx
# run onboard
# run volumeicon

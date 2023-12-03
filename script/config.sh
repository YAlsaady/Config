#!/bin/zsh

config=$(echo "Awosome\nNeovim\nAlacritty\nKitty\nNeofetch\nRanger\nSXHKD\nRofi\nZathura\nZsh\nPicom\nBash\nLinux\nScripts\nUdiskie" | dmenu -i -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn DejaVuSansMonoNerdFont:bold:pixelsize=15 -b -p "Config-File:")

[ $config = "Awosome" ]     && alacritty -e nvim /home/yaman/.config/awesome
[ $config = "Neovim" ]      && alacritty -e nvim /home/yaman/.config/nvim
[ $config = "Alacritty" ]   && alacritty -e nvim /home/yaman/.config/alacritty/alacritty.yml
[ $config = "Kitty" ]       && alacritty -e nvim /home/yaman/.config/kitty/kitty.conf
[ $config = "Neofetch" ]    && alacritty -e nvim /home/yaman/.config/neofetch/config.conf
[ $config = "Ranger" ]      && alacritty -e nvim /home/yaman/.config/ranger
[ $config = "SXHKD" ]       && alacritty -e nvim /home/yaman/.config/sxhkd/sxhkdrc
[ $config = "Rofi" ]        && alacritty -e nvim /home/yaman/.config/rofi/config.rasi
[ $config = "Zathura" ]     && alacritty -e nvim /home/yaman/.config/zathura/zathurarc
[ $config = "Zsh" ]         && alacritty -e nvim /home/yaman/.config/zsh/.zshrc
[ $config = "Picom" ]       && alacritty -e nvim /home/yaman/.config/picom/picom.conf
[ $config = "Bash" ]        && alacritty -e nvim /home/yaman/.bashrc
[ $config = "Linux" ]       && alacritty -e nvim /home/yaman/Documents/Linux/linux.md
[ $config = "Scripts" ]     && alacritty -e nvim /home/yaman/.script/
[ $config = "Udiskie" ]     && alacritty -e nvim /home/yaman/.config/udiskie/config.yml

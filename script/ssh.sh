#!/bin/zsh

ssh=$(echo "Print\nRobot\nHolePI\nDelta\nDeltapi" | dmenu -i -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn DejaVuSansMonoNerdFont:bold:pixelsize=15 -b -p "SSH TO:")

[ $ssh = "Print" ]     && alacritty -e ssh alsaady@print.local
[ $ssh = "Robot" ]     && alacritty -e ssh alsaady@robot.local
[ $ssh = "HolePI" ]     && alacritty -e ssh alsaady@hole.local
[ $ssh = "Delta" ]     && alacritty -e ssh robot@192.168.3.11
[ $ssh = "Deltapi" ]   && alacritty -e ssh delta@technikum.local

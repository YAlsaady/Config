#!/bin/bash
if pgrep -x "picom" > /dev/null
then
	killall picom
else
	picom
	# picom -b --config ~/.config/awesome/picom.conf
fi
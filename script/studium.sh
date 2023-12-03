#!/bin/zsh

config=$(echo "Elektrotechnik\nMathematik\nProgrammieren\nEinführung_in_die_Informatik\nPhysik\nSchlüsselqualifikationen" | dmenu -i -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn DejaVuSansMonoNerdFont:bold:pixelsize=15 -b -p "Config-File:")

[ $config = "Elektrotechnik" ]     && alacritty -e ranger $HOME/Studium/1.Semster/Elektro
[ $config = "Mathematik" ]      && alacritty -e ranger $HOME/Studium/1.Semster/Mathe
[ $config = "Programmieren" ]   && alacritty -e ranger $HOME/Studium/1.Semster/Programmieren
[ $config = "Einführung_in_die_Informatik" ]       && alacritty -e ranger $HOME/Studium/1.Semster/Informatik
[ $config = "Physik" ]    && alacritty -e ranger $HOME/Studium/1.Semster/Physik
[ $config = "Schlüsselqualifikationen" ]      && alacritty -e ranger $HOME/1.Semster/Studium/Schlüsselqualifikationen
# [ $config = "" ]       && alacritty -e ranger ./Studium/
# [ $config = "" ]        && alacritty -e ranger ./Studium/
# [ $config = "" ]     && alacritty -e ranger ./Studium/
# [ $config = "" ]         && alacritty -e ranger ./Studium/
# [ $config = "" ]        && alacritty -e ranger ./Studium/
# [ $config = "" ]       && alacritty -e ranger ./Studium/
# [ $config = "" ]     && alacritty -e ranger ./Studium/

# Created by newuser for 5.9
export ZDOTDIR="$HOME"/.config/zsh
export HISTFILE=~/.config/zsh/.zsh_history

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export BROWSER='brave'
export TERMINAL='alacritty'
source ~/.zprofile

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# export GTK_PATH=/usr/lib64/gtk-2.0
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio
export PATH="${PATH}:/home/yaman/.local/share/cargo/bin"
fpath=($HOME/.config/zsh/compeltion $fpath)
PATH=$PATH:$HOME/.script                        #making my scripts run without typing the whole path
# export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# export XAUTHORITY=$HOME

# HISTFILE=10000
SAVEHIST=10000
# setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

autoload -U colors && colors

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select 'm:{a-zA-Z}={A-Za-z}'

# CASE_SENSITIVE="false"

PROMPT='%F{yellow}%1~%f %F{white}∯%f '
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

## Git Settings
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}  %b%f'
# zstyle ':vcs_info:git:*' formats '%F{yellow}  (%b) %r%f'
zstyle ':vcs_info:*' enable git
#   
#[[ -f ~/.zshrc-alsaady ]] && . ~/.zshrc-alsaady
#alias
alias v='nvim'
alias f='ranger'
alias t='bpytop'

#pacman
alias I='sudo pacman --color auto -Sy'
alias R='sudo pacman --color auto -Rs'
alias S='sudo pacman --color auto -Ss'
# alias up='sudo pacman --color auto -Syyu'
alias up='yay --color auto -Syyu'
alias Ia='yay -Sy'
alias Ra='yay -Rs'
alias Sa='yay -Ss'

#LSD
alias ls='lsd --git --header'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

#Monitor
alias mon='~/.script/hp.sh'
alias 2mon='~/.script/hp_peaq.sh'

#switch between lightdm and sddm
alias tolightdm="sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"

alias tosddm="sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.RAR)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.ZIP)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias sbc86='/home/yaman/Studium/2.Semster/Hardwarenahe_Programmierung/SBC86_Simulator/sbc86sim_linux_qt5_x86_64_1.2.5/simu86 &'
asm() {
    nasm -f bin "$1".asm -o "$1".com
}
alias delta='ssh robot@192.168.3.11'
alias deltapi='ssh delta@technikum.local'
alias printpi='ssh alsaady@print.local'
alias robotpi='ssh alsaady@robot.local'
alias holepi='ssh alsaady@hole.local'
alias naspi='ssh alsaady@nas.local'

alias clear='clear && fortune ~/src/Config/fortune/quotes'
fortune ~/src/Config/fortune/quotes
# neofetch

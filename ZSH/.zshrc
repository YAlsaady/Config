export ZDOTDIR="$HOME"/.config/zsh
export HISTFILE=~/.config/zsh/.zsh_history

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export PLATFORMIO_CORE_DIR="$XDG_DATA_HOME"/platformio

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
export BROWSER='brave'
export TERMINAL='alacritty'
source ~/.zprofile

export PATH="${PATH}:/home/yaman/.local/share/cargo/bin"
PATH=$PATH:$HOME/.script

SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS

autoload -U colors && colors

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select 'm:{a-zA-Z}={A-Za-z}'

PROMPT='%F{yellow}%1~%f %F{white}∯%f '
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

## Git Settings
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}  %b%f'
zstyle ':vcs_info:*' enable git


#alias
alias v='nvim'
alias f='ranger'
alias t='bpytop'

#pacman
alias I='sudo pacman --color auto -Sy'
alias R='sudo pacman --color auto -R'
alias S='sudo pacman --color auto -Ss'
alias up='yay --color auto -Syyu'
alias Ia='yay -Sy'
alias Ra='yay -R'
alias Sa='yay -Ss'

#LSD
alias ls='lsd --git --header'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'



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

# neofetch

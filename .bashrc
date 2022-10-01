#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## VARS
### Path
export PATH=$PATH:/home/talocha/.local/bin:/home/.local:/home/talocha/.cargo/bin
export VISUAL=emacsclient
export EDITOR="$VISUAL"

## Colors
_WHITE=$(tput setaf 7)
_RESET=$(tput sgr0)

### alias
alias ls='ls --color=auto'
alias la='ls -la'
alias audio='pavucontrol'
alias emacs='emacsclient -nc'
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'


## VPN
# Prague (CZ)
alias vpnonCZ='nmcli con up 4fd1bf9e-7e60-4720-a588-b4455cf8d97a'
alias vpnoffCZ='nmcli con down 4fd1bf9e-7e60-4720-a588-b4455cf8d97a'

PS1='\[${_WHITE}\]\w [\u \A]\n \[${_RESET}\]﬌ '

neofetch


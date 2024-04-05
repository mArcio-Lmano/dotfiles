#
# ~/.bash_profile
#
#

PATH=$PATH:$HOME/.local/bin
export PATH

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

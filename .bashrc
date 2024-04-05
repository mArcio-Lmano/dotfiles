#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

parse_git_branch() {
    git branch 2>/dev/null | sed -n 's/^\* \(.*\)/ (\1)/p'
}

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[1;36m\]\w\[\033[00m\]\[\033[1;33m\]\$(parse_git_branch)\[\033[00m\]\$ "

alias ls='ls --color=auto'

export LD_LIBRARY_PATH="/usr/local/lib:$HOME/PyTorch/libtorch/lib:$LD_LIBRARY_PATH"
export LIBTORCH="$HOME/PyTorch/libtorch"

. "$HOME/.cargo/env"


export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin

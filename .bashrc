# .bashrc

# User specific aliases and functions
export PATH=/usr/local/bin/svn/bin:$PATH

svndiff() { vimdiff <(svn cat "$1") "$1"; }

alias ls="ls --color"


# Source any local definitions
if [ -f ~/.bashrc.local ]; then
 . ~/.bashrc.local
fi





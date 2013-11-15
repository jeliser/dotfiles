# .bashrc


# Source distribution bashrc
if [ -f "/etc/bashrc" ]; then
 . "/etc/bashrc"
fi


# Load dircolors if available
if [ -f "$HOME/.dircolors" ] ; then
  eval $(dircolors -b $HOME/.dircolors)
fi


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Uncomment to enable color prompt
color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n> '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias scons='scons -j 10'
alias svnstat='svn status | grep ^[^?]'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# User specific aliases and functions
export PATH=/usr/local/bin/svn/bin:$PATH


# Some helpful functions
svndiff() { vimdiff <(svn cat "$1") "$1"; }
ag() { grep "$1" --exclude=\*.svn-base -n ./* $2; }


# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
  source "$file"
done
shopt -u nullglob

# Source any local definitions
if [ -f "~/.bashrc.local" ]; then
 . "~/.bashrc.local"
fi



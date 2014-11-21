# .bashrc


# Source distribution bashrc
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=always'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias sc='scons -u -j 10'
alias svnstat='svn status | grep ^[^?]'
alias pg='ps aux | grep'
alias k9='sudo kill -9'

# Determine if the clientserver option is available on the machine
if [ `vim --version | grep "+clientserver" | wc -l` -gt 0 ]; then
  alias vim='vim --servername jeliser '
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# User specific aliases and functions
export PATH=/usr/local/bin/svn/bin:$PATH
export PATH=/usr/local/bin/:$PATH


# Some helpful functions
svndiff() { vimdiff <(svn cat "$1") "$1"; }
ag() { grep "$1" --exclude=\*.svn-base --exclude-dir=.. -n .* $2; }
tree() { ls -R $1 | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'; }

# Bunch of git command shortcuts
gs() { git status -sb; }
gits() { git status -sb; }
gc() { git clean -dxf; }
gitclean() { git clean -dxf; }
gitdiff() { git difftool -y --tool=vimdiff "$1"; }
gitpatch() { git diff --no-ext-diff -w "$@" | vim -R -; }
gitcm() { git commit -m "$@"; }
gitba() { git branch -a "$@"; }
gitbl() { git branch -l "$@"; }
gitcount() { git rev-list HEAD --count; }
gitlog() { git log --no-merges "$@"; }
gitsize() {
  if [ "$#" -ne 1 ]; then
    git_size 10;
  else
    git_size $1
  fi
}
gitconflict() { vim $(git status -s | grep ^UU | cut -f 2 -d ' '); }
alias gitcon='gitconflict'
githist() {
  if [ "$#" -eq 1 ]; then
    git hist | grep -i $1 | grep -v "Merge" | less -RS;
  else
    git hist;
  fi
}


# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
  source "$file"
done
shopt -u nullglob


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


# Comment this line in order to stop the crazy command line
ps1_set --prompt


# Source any local definitions
if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi


# Example of auto-complete loading for git.  I added this to my .bashrc.local
#if [ -f /home/eliserjm/mace_dev/tmp/git-1.8.5.1/contrib/completion/git-completion.bash ]; then
#  . /home/eliserjm/mace_dev/tmp/git-1.8.5.1/contrib/completion/git-completion.bash
#fi


# Example of auto-generating a log with a JIRA ticket
#gitcommit() {
#  PREFIX=""
#  HEADER="JIRA-"
#  BRANCH_NAME=`git branch | grep "*" | awk '{print $2}'`
#
#  if [[ $BRANCH_NAME =~ $HEADER ]] ; then
#    PREFIX="JBCP-`echo $BRANCH_NAME | sed "s/-/ /g" | awk '{print $2}'`: #comment "
#  fi
#
#  git commit -m "$PREFIX$@"
#}



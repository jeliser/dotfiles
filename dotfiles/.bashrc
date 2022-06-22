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

alias k9='kill -9'
alias sk9='sudo kill -9'
alias jb='cd >/dev/null 2>&1;cd -'  # Jump back
alias sb='source ~/.bashrc'
alias ssh='ssh -X'
alias wget='wget -c' # wget --continue

alias sc='scons -u -j 10'
alias scd='sc --with-debug'
alias svnstat='svn status | grep ^[^?]'

alias acgdb='ASAN_OPTIONS="detect_odr_violation=2:abort_on_error=1:color=never" cgdb'
alias dbg='\cgdb -d /opt/gdb-7.6/bin/gdb --args'

alias ctop='circus-top'
alias clist='circusctl list'
alias cstat='circusctl status'
alias cinfo='cstat'
alias cquit='circusctl quit'
alias crestart='circusctl restart'
alias cstop='circusctl stop'
alias cstart='circusctl start'
alias cr='crestart'

alias afacts='ansible -m setup -c local -i "localhost" 127.0.0.1'

alias urldecode='python3 -c "import sys, urllib.parse as ul; \
      print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
      print (ul.quote_plus(sys.argv[1]))"'

alias wget_all='wget -r -nH --cut-dirs=2 --no-parent --reject="index.html*"'
alias compress='tar -czvf'

# https://stackoverflow.com/questions/8696751/add-space-between-every-letter
insert_space() { echo "$@" | sed -e 's/\(.\)/\1 /g'; }
jenkins_leak() { insert_space $@; }

alias clean_untracked='git clean -xdff'
alias windows_key='sudo strings /sys/firmware/acpi/tables/MSDM'

showlog() { watch "sort -k 1 -k 2 -s $1* | tail $2 $3"; }
alias sl='showlog'

alias netudp='netstat -apue'
alias nettcp='netstat -apte'

udi() { udevadm info -a -p $( udevadm info -q path -n $1 ); }

demangle() { nm $1 | c++filt; }
show_exit() { echo $?; }

# Determine if the clientserver option is available on the machine
if [ `vim --version | grep "+clientserver" | wc -l` -gt 0 ]; then
  alias vim='vim --servername jeliser '
fi


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# User specific aliases and functions
export PATH=$HOME/local/bin:/usr/local/bin:/usr/local/bin/svn/bin:$PATH
# Force git to always use the CLI.  I dislike the OpenSSH popup dialog
export GIT_ASKPASS=
export TICKET_NAME=/


# Some helpful functions
svndiff() { vimdiff <(svn cat "$1") "$1"; }
pg() { ps aux | grep "$@" | grep -v "grep"; }
pk() { kill -9 $( pidof $@ ); }
lslong() { find $1/ -printf "%p\t%s\n"; }
ag() { grep "$1" --exclude=\*.svn-base --exclude-dir=.. --exclude-dir=.git --exclude-dir=.work* --exclude=\*.ipynb --exclude=\*.swp -n .* -r $2; }
gr() { ag "$1" -r | column -t -s ':' | awk '{ print $1 }' | uniq | xargs sed -i s$'\001'"$1"$'\001'"$2"$'\001''g'; }
# Do something with the line replacement regex .. .*(Nop\(\);)(\r\n|\r|\n)
#tree() { ls -R $1 | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'; }

alias stream_camera='mjpg-streamer -i "input_uvc.so -d /dev/video0 -r 640x480 -f 10" -o "output_http.so -w ./www -p 5555"'

# Read all the interesting bits from sub-files.
shopt -s nullglob
for file in "$HOME/.bash_profile.d"/*.sh; do
  source "$file"
done
shopt -u nullglob

# Some helper methods for running Juypter on a local machine.
jupyter_create() { create_ve jupyter; pip install jupyter; }
jupyter_start() { ve jupyter; jupyter notebook --NotebookApp.token='' --NotebookApp.password=''; }

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




#!/usr/bin/env bash

#
# Source this file in your ~/.bash_profile or interactive startup file.
# This is done like so:
#
#    [[ -s "$HOME/.rvm/contrib/ps1_functions" ]] &&
#      source "$HOME/.rvm/contrib/ps1_functions"
#
# Then in order to set your prompt you simply do the following for example
#
# Examples:
#
#   ps1_set --prompt ∫
#
#   or
#
#   ps1_set --prompt ∴
#
# This will yield a prompt like the following, for example,
#
# 00:00:50 wayneeseguin@GeniusAir:~/projects/db0/rvm/rvm  (git:master:156d0b4)  ruby-1.8.7-p334@rvm
# ∴
#

RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[00;35m\]"
BOLD_PURPLE="\[\033[01;35m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

ps1_identity()
{
  if [[ $UID -eq 0 ]]  ; then
    COLOR1="${RED}"
    COLOR2="${BROWN}"
  else
    COLOR1="${GREEN}"
    COLOR2="${BROWN}"
  fi

  printf "${GREY}[${COLOR1}\\\u${GREY}@${COLOR2}\\h${GREY}:${BOLD_PURPLE}\w${GREY}]${COLOR2}  "

  return 0
}

ps1_rvm()
{
  if command -v rvm-prompt >/dev/null 2>/dev/null ; then
    printf " $(rvm-prompt) "
  fi
}

ps1_set()
{
  local prompt_char='$'
  local separator="\n"
  local notime=0

  if [[ $UID -eq 0 ]] ; then
    prompt_char='#'
  fi

  while [[ $# -gt 0 ]] ; do
    local token="$1" ; shift

    case "$token" in
      --trace)
        export PS4="+ \${BASH_SOURCE##\${rvm_path:-}} : \${FUNCNAME[0]:+\${FUNCNAME[0]}()}  \${LINENO} > "
        set -o xtrace
        ;;
      --prompt)
        prompt_char="$1"
        shift
        ;;
      --noseparator)
        separator=""
        ;;
      --separator)
        separator="$1"
        shift
        ;;
      --notime)
        notime=1
        ;;
      *)
        true # Ignore everything else.
        ;;
    esac
  done

  PS1="\n$(ps1_identity)\[\033[34m\]\$(ps1_rvm)\[\033[0m\]${separator}${BLUE}${prompt_char} ${PS_CLEAR}> "
}

ps2_set()
{
  PS2="  \[\033[0;40m\]\[\033[0;33m\]> \[\033[1;37m\]\[\033[1m\]"
}


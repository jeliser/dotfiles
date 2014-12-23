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

ps1_git()
{
  local branch="" line="" attr=""

  shopt -s extglob # Important, for our nice matchers :)

  if ! command -v git >/dev/null 2>&1 ; then
    printf " \033[1;37m\033[41m[git not found]\033[m "
    exit 0
  fi

  # Get the branch and SHA values
  branch=$( git branch 2>/dev/null | grep "*" | awk -F' ' '{print $NF}' )
  sha1=$( git rev-parse --verify HEAD --short 2>/dev/null )

  case ${branch} in
   production|prod) attr="1;37m\033[" ; color=41 ;; # red
   master|deploy)   color=31                     ;; # red
   stage|staging)   color=33                     ;; # yellow
   dev|development) color=34                     ;; # blue
   next)            color=36                     ;; # gray
   *)
     if [[ -n "${branch}" ]] ; then # Feature Branch :)
       color=32 # green
     else
       color=0 # reset
     fi
     ;;
  esac

  if [[ $color -gt 0 ]] ; then
    if [[ -n $attr ]] ; then
      printf "\[\033[%s%sm\](git:${branch}:$sha1)\[\033[0m\]" "${attr}" "${color}"
    else
      printf "(git:${branch}:${sha1}) " 
    fi
  fi

  return 1
}

ps1_rvm()
{
  if command -v rvm-prompt >/dev/null 2>/dev/null ; then
    printf " $(rvm-prompt) "
  fi
}

ps1_ahead_behind()
{
  STATUS=`git status -sb 2>/dev/null | grep -o -P '(?<=\[).*(?=\])'`
  AHEAD=`echo ${STATUS} | grep -o -P '(?<=ahead )[0-9]*'`
  BEHIND=`echo ${STATUS} | grep -o -P '(?<=behind )[0-9]*'`
  GREEN="\033[32m"
  RED="\033[31m"
  CLEAR="\033[0m"

  if [ `echo ${AHEAD} | wc -w` -gt 0 ] && [ `echo ${BEHIND} | wc -w` -gt 0 ]; then
    printf "[ahead ${GREEN}${AHEAD}${CLEAR}, behind ${RED}${BEHIND}${CLEAR}]"
  elif [ `echo ${AHEAD} | wc -w` -gt 0 ]; then
    printf "[ahead ${GREEN}${AHEAD}${CLEAR}]"
  elif [ `echo ${BEHIND} | wc -w` -gt 0 ]; then
    printf "[behind ${RED}${BEHIND}${CLEAR}]"
  fi

  return 1
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


  PS1="\n$(ps1_identity)\[\033[34m\]\$(ps1_git)\$(ps1_rvm)\[\033[0m\]\$(ps1_ahead_behind)${separator}${BLUE}${prompt_char} ${PS_CLEAR}> "
}

ps2_set()
{
  PS2="  \[\033[0;40m\]\[\033[0;33m\]> \[\033[1;37m\]\[\033[1m\]"
}


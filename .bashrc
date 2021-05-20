# return if not running interactively
[[ -z "$PS1" ]] && return

export TERM=xterm-256color

# setting history
## ignore duplicate lines and commands with leading space
export HISTCONTROL=ignoreboth
## amount of command history for current active bash session
export HISTSIZE=1000
## amount of command history that was input at all
export HISTFILESIZE=10000

# set default editor
export EDITOR=vi
if which nvim &>/dev/null; then export EDITOR=nvim; fi

export PAGER=less
## set styles for `less` output
export LESS_TERMCAP_md=$(tput bold; tput setaf 12)
export LESS_TERMCAP_us=$(tput sitm; tput setaf 8)

# expand aliases (to use in scripts)
shopt -s expand_aliases
# save command to history after each input
shopt -s histappend
# fix spelling errors for cd, only in interactive shell
shopt -s cdspell
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# save multiline command to history as single line
shopt -s cmdhist

_color() {
  local str="${1}\[$(tput sgr0)\]"
  local code=-1

  case "${2}" in
    lblack) code=8;;
    black) code=0;;
    lred) code=9;;
    red) code=1;;
    lgreen) code=10;;
    green) code=2;;
    lyellow) code=11;;
    yellow) code=3;;
    lblue) code=12;;
    blue) code=4;;
    lmagenta) code=13;;
    magenta) code=5;;
    lcyan) code=14;;
    cyan) code=6;;
    lwhite) code=15;;
    white) code=7;;
  esac
  str="\[$(tput setaf ${code})\]${str}"

  if [[ -n "${3}" ]]; then
    case "${3}" in
      lblack) code=8;;
      black) code=0;;
      lred) code=9;;
      red) code=1;;
      lgreen) code=10;;
      green) code=2;;
      lyellow) code=11;;
      yellow) code=3;;
      lblue) code=12;;
      blue) code=4;;
      lmagenta) code=13;;
      magenta) code=5;;
      lcyan) code=14;;
      cyan) code=6;;
      lwhite) code=15;;
      white) code=7;;
    esac
    str="\[$(tput setab $code)\]${str}"
  fi

  echo "${str}"
}

dynamic_user_prompt() {
  if (( $? != 0 )); then
    local prompt=$(_color ">" "red")
  else
    local prompt=$(_color ">" "green")
  fi

  local user_color="cyan"
  if (( $UID == 0 )); then user_color="red"; fi

  local time=$(_color "\t" $user_color)
  local dir=$(_color "\w" "yellow")
  local git_branch=$(git branch --show-current 2>/dev/null)
  if [[ -n "${git_branch}" ]]; then
    git_branch=$(_color " (${git_branch})" "magenta")
  fi

  local left="${dir}${git_branch}"

  local right="${time}"

  local both_length=$((( $(expr length "${left}") + $(expr length "${right}") )))

  PS1="${right} ${left}\n${prompt} "
  if (( $(tput cols) > $both_length )); then
    local right_offset=$((( $(tput cols) + 13 )))
    PS1=$(printf "%*s\r%s\n%s" "${right_offset}" "${right}" "${left}" "${prompt} ")
  fi

  return 0
}

# enable save command of current session to history after input
# enable dynamic user prompt
PROMPT_COMMAND="dynamic_user_prompt; history -a"

##
## LS
##
eval $(dircolors | sed 's/01;/00;/g')

##
## FZF
##
[[ -f /usr/share/fzf/key-bindings.bash ]] \
  && source /usr/share/fzf/key-bindings.bash

export FZF_DEFAULT_OPTS="--ansi \
  --no-bold \
  --tabstop=4 \
  --marker \* \
  --height 100% \
  --reverse \
  --multi \
  --bind=ctrl-a:toggle-all \
  --color=fg:0,bg:-1,hl:5,fg+:0,bg+:11,hl+:5,info:8,prompt:0,pointer:5,marker:2,spinner:6,header:8,gutter:-1,query:5"

export FZF_DEFAULT_COMMAND='rg --files -uu'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND} 2>/dev/null"

# remap Ctrl+t to Ctrl+f
bind -m emacs-standard -x '"\C-f": fzf-file-widget'
bind -m vi-command -x '"\C-f": fzf-file-widget'
bind -m vi-insert -x '"\C-f": fzf-file-widget'

export FZF_ALT_C_COMMAND="rg --files \
  --no-messages \
  --null -uu ~ | xargs -0 dirname | sort | uniq"
export FZF_ALT_C_OPTS=""

if [[ -f ~/.aliases ]]; then . ~/.aliases; fi

if (( $(ps | grep 'ssh-agent' | wc -l) < 2 )); then
  eval $(ssh-agent) &>/dev/null
  ssh-add -q ${HOME}/.ssh/* &>/dev/null
fi

# autorun services
if [[ ! -f "/run/openrc/softlevel" ]]; then
  su -c "(rc-status  && touch /run/openrc/softlevel \
    && rc-service docker start) &>/dev/null"
fi


#!/usr/bin/env bash

ANSI_ESC=$'\033'
ANSI_CSI="${ANSI_ESC}["

_ansi_bg() {
  printf '\[%s48;5;%sm\]' "$ANSI_CSI" "$1"
}

_ansi_fg() {
  printf '\[%s38;5;%sm\]' "$ANSI_CSI" "$1"
}

_ansi_bold() {
  printf '\[%s1m\]' "$ANSI_CSI"
}

_ansi_reset() {
  printf '\[%s0m\]' "$ANSI_CSI"
}

_section() {
  printf '%s%s' "$(_ansi_bg $1)" "$(_ansi_fg 15)"
}

_arrow() {
  local arrow=''
  if [[ $# -eq 1 ]]; then
    printf '%s%s%s%s' "$(_ansi_reset)" "$(_ansi_fg "$1")" "$arrow" "$(_ansi_reset)"
  else
    printf '%s%s%s' "$(_ansi_fg "$1")" "$(_ansi_bg "$2")" "$arrow"
  fi
}

bash_prompt() {
  # Remember to install powerline fonts
  local last="$(_arrow 23)"
  local prompt=$(__git_ps1 " %s")
  if [[ -n "$prompt" ]]; then
    local color="42" # green
    if [[ "$prompt" =~ ^.*\|(MERGING|REBASE).*$ ]]; then
      color="165" # purple
    elif [[ "$prompt" =~ ^.*-[0-9]*$ ]]; then
      color="196" # red
    elif [[ "$prompt" =~ ^.*\+[0-9]*$ ]]; then
      color="75" # light blue
    elif [[ "$prompt" =~ ^.*\+.*$ ]]; then
      color="73" # grayish blue
    elif [[ "$prompt" =~ ^.*(%|\*).*$ ]]; then
      color="179" # orange
    fi
    local branch=''
    local gitdir="$(git rev-parse --git-dir)"
    gitdir="${gitdir##*/}"
    if [[ "$gitdir" != ".git" ]]; then
      prompt=" (${gitdir})${prompt}"
    fi
    last="$(_arrow 23 $color)  $(_ansi_reset)$(_section $color)${branch}$(_ansi_bold)${prompt} $(_arrow $color)"
  fi

  local aws_session=''
  if [[ -n "$AWS_CREDENTIAL_EXPIRATION" ]]; then
    local profile=''
    if [[ -n "$AWS_VAULT" ]]; then
      profile="$AWS_VAULT "
    fi
    aws_session=" (${profile}$(date --date="$AWS_CREDENTIAL_EXPIRATION" +%H:%M))"
  fi

  local line1="$(_ansi_bold)$(_section 30)  \u@not-computer${aws_session} $(_arrow 30 23)$(_section 23)  \w ${last}"
  local line2="$(_section 32)  \A $(_arrow 32) "
  PS1="\n${line1}\n${line2}"
}

shopt -s histappend
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND="history -a; history -c; history -r; bash_prompt"

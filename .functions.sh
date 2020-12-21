#!/usr/bin/env bash

# Functions

if command -v bat >/dev/null; then
  BAT_PATH=$(which bat)
  function bat() {
    $BAT_PATH --color always --theme=TwoDark --paging never "$@" | less
  }
fi
complete -o default -F _fzf_path_completion bat

# run interactive bash in docker container
dr() {
  if [[ $# -ne 1 ]]; then
    echo "dr {image}"
    return 1
  fi
  local image="$1"
  docker run --interactive --tty --rm --entrypoint /bin/bash "$image"
}

# find and replace
fr() {
  if [[ $# -ne 2 ]]; then
    echo "ft {text_to_find} {replacement_text}"
    return 1
  fi

  fd --type f --exec sed -i '' -e "s/$1/$2/g" {} \;
}

# interactively find process to kill
fkill() {
  local pid
  if [[ "$UID" != "0" ]]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [[ "x$pid" != "x" ]]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

# print color table
color() {
  printf "%s\n" '\e[38;5;COLOR_CODEm is a foreground color'
  printf "%s\n" '\e[48;5;COLOR_CODEm is a background color'
  printf "%s\n" '\e[1m is bold and \e[0m ends a sequence'
  local val
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && printf "\n"
  done
}

# base64 encode a string without the newline
b64() {
  if [[ "$(uname)" == "Linux" ]]; then
    printf "%s" "$@" | base64 -w 0
  else
    # macos defaults the line wrapping to 0 already
    printf "%s" "$@" | base64
  fi
  echo
}

# pick a random homebrew formulae to display in new shells
brew_random() {
  if [[ -n "$(type -t cowsay)" ]]; then
    cat ~/.random_brew_cmd 2>/dev/null
    local formulae=($(brew formulae | grep -v /))
    local desc=$(brew desc "${formulae[$((RANDOM % ${#formulae[@]}))]}" 2>/dev/null)
    [[ $? -eq 0 ]] && cowsay "$desc" > ~/.random_brew_cmd
  fi
}
(brew_random &)

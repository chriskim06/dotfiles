#!/usr/bin/env bash

# Functions

if command -v bat >/dev/null; then
  BAT_PATH=$(which bat)
  function bat() {
    $BAT_PATH --color always --theme=TwoDark --paging never "$@" | less
  }
fi
complete -o default -F _fzf_path_completion bat

bs() {
  cat << EOF > "$1"
#!/usr/bin/env bash

set -euo pipefail


EOF
  chmod +x "$1"
  vim "$1"
}

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

  if [[ "$(uname)" == "Darwin" ]]; then
    fd --type f --exec sed -i "s|$1|$2|g" {} \;
  else
    fd --type f --exec sed -i '' -e "s/$1/$2/g" {} \;
  fi
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
  printf "%s" "$@" | base64 -w 0
}

# pick a random krew plugin to display in new shells
krew_random() {
  if [[ -n "$(type -t cowsay)" && -n "$(type -t yq)" ]]; then
    cat ~/.random_krew_plugin 2>/dev/null
    (__krew_random_helper &)
  fi
}

__krew_random_helper() {
  local plugins=($(krew search | tail -n +2 | sed 's/ .*//g'))
  local random_plugin="${plugins[$((RANDOM % ${#plugins[@]}))]}"
  local index="default"
  local plugin="$random_plugin"
  if [[ "$random_plugin" == *"/"* ]]; then
    index="$(echo ${random_plugin%%/*})"
    plugin="$(echo ${random_plugin##*/})"
  fi
  local info="$(cat ~/.krew/index/${index}/plugins/${plugin}.yaml | yq -r '.spec.shortDescription')"
  [[ $? -eq 0 ]] && cowsay "${random_plugin}: ${info}" > ~/.random_krew_plugin
}

krew_random

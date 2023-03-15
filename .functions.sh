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
    index="${random_plugin%%/*}"
    plugin="${random_plugin##*/}"
  fi
  local info
  info="$(cat ~/.krew/index/${index}/plugins/${plugin}.yaml | yq -r '.spec.shortDescription')"
  [[ $? -eq 0 ]] && cowsay "${random_plugin}: ${info}" > ~/.random_krew_plugin
}

wm() {
  if [[ ! -d "$HOME/.config/workspaces" ]]; then
    mkdir -p "$HOME/.config/workspaces"
  fi
  local listfile="$HOME/.config/workspaces/list"
  if [[ ! -f $listfile ]]; then
    touch "$listfile"
  fi

  if [[ $# -eq 0 ]]; then
    local dest
    dest=$(fzf --height 30% < "$listfile")
    if [[ -n "$dest" ]]; then
      dest=${dest#*: }
      echo "switching to $dest"
      cd "$dest" || return
      ls -lAh
      return
    fi
  fi

  while [[ $# -gt 0 ]]; do
    case $1 in
      add)
        [[ $# -ne 2 ]] && echo "must provide a workspace name"
        echo "$2: $(pwd)" >> "$listfile"
        return
        ;;
      delete|rm)
        [[ $# -ne 2 ]] && echo "must provide a workspace name"
        sed -i "/^$2/d" "$listfile"
        return
        ;;
      list|ls)
        cat "$listfile"
        return
        ;;
      help|-h|--help)
        echo "saves commonly used directories to easily switch to"
        echo
        echo "when invoked with no arguments it will allow you to choose"
        echo "from the list of workspaces to switch to"
        echo
        echo "valid args:"
        echo "  - ls|list: list the available workspaces"
        echo "  - add {name}: save the current directory to workspaces with {name}"
        echo "  - rm|delete {name}: delete directory {name} from workspaces"
        return
        ;;
      *)
        ;;
    esac
  done
}

krew_random

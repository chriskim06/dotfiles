#!/usr/bin/env bash

# Functions

man() {
  if [[ $# -eq 1 && -n "$1" && "$(type -t "$1")" == "builtin" ]]; then
    help "$1"
  else
    command man "$@"
  fi
}

bs() {
  if [[ -e "$1" ]]; then
    echo "$1 already exists"
    return 1
  fi
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
    val="$(printf '%03d' "$code")"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && printf "\n"
  done
}

# base64 encode a string without the newline
b64() {
  printf "%s" "$@" | base64 -w 0
}

# function to show symlink target for which
is() {
  if [[ $# -ne 1 ]]; then
    echo "must provide binary name"
    return 1
  fi
  p=$(which "$1")
  if [[ -z "$p" ]]; then
    return 1
  fi
  printf "\e[38;5;2m%s\e[0m" "$p"
  if [[ -L "$p" ]]; then
    r=$(realpath "$p")
    printf " -> \e[38;5;135m%s\e[0m\n" "$r"
    return 0
  fi
  echo
}

# simple workspace manager
wm() {
  local config_dir="$HOME/.config/workspaces"
  local listfile="$config_dir/list"
  [[ ! -d "$config_dir" ]] && mkdir -p "$config_dir"
  [[ ! -f $listfile ]] && touch "$listfile"

  if [[ $# -eq 0 ]]; then
    local dest
    dest=$(fzf --height 30% < "$listfile")
    if [[ -n "$dest" ]]; then
      dest=${dest##* }
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
        local updated=$(printf '%s\n%s' "$(cat "$listfile")" "$2: $(pwd)" | sort | column -t)
        echo "$updated" > "$listfile"
        echo "added $(pwd) to workspaces as $2"
        return
        ;;
      rm)
        [[ $# -eq 2 ]] && sed -i "/^$2:/d" "$listfile" && return
        local dir
        dir=$(fzf --height 30% < "$listfile")
        if [[ -n "$dir" ]]; then
          dir=${dir%:*}
          sed -i "/^$dir:/d" "$listfile"
        fi
        return
        ;;
      ls)
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
        echo "  - ls: list the available workspaces"
        echo "  - add {name}: save the current directory to workspaces with {name}"
        echo "  - rm {name}: delete directory {name} from workspaces or pick if no name is given"
        return
        ;;
      *)
        return
        ;;
    esac
  done
}

# pick a random krew plugin to display in new shells
krew_random() {
  if [[ -n "$(type -t cowsay)" && -n "$(type -t yq)" ]]; then
    cat ~/.random_krew_plugin 2>/dev/null
    (__krew_random_helper &)
  fi
}

__krew_random_helper() {
  local index_dir plugins random_plugin name info

  index_dir="${HOME}/.krew/index/default/plugins"
  mapfile -t plugins < <(find "$index_dir" -type f)
  random_plugin="${plugins[$((RANDOM % ${#plugins[@]}))]}"
  name="$(yq -r '.metadata.name' "$random_plugin")"
  info="$(yq -r '.spec.shortDescription' "$random_plugin")"
  [[ "$name" != "" && "$info" != "" ]] && cowsay "${name}: ${info}" > ~/.random_krew_plugin
}

krew_random

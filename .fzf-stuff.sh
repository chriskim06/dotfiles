#!/usr/bin/env bash

# fzf stuff

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

fshow() { # {{{
  local d="$(date -v-1y +%F)"
  git lg --since=\{"$d"\} | fzf --ansi --no-sort --tiebreak=index --bind "enter:execute:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show %')"
} # }}}

fstash() { # {{{
  local out k
  while out=$(git stash list --pretty="%C(bold 227)%gd %C(bold 14)<%ar> %C(bold 15)%gs" | fzf --ansi --no-sort --print-query --expect=ctrl-d,ctrl-p); do
    mapfile -t out <<< "$out"
    k="${out[1]}"
    stash_id="${out[-1]}"
    stash_id="${stash_id%% *}"
    [[ -z "$stash_id" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git stash drop $stash_id
    elif [[ "$k" == 'ctrl-p' ]]; then
      git stash pop $stash_id
      break;
    else
      git stash show -p $stash_id
    fi
  done
} # }}}

complete -F _fzf_path_completion -o default -o bashdefault vim

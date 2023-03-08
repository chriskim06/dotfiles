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

fstash() {
  local out q sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
      fzf --ansi --no-sort --query="$q")
  do
    read -a out <<< $out
    sha="${out[0]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    git stash show -p $sha
  done
}

fshow() {
  _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
  _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
  git log --color=always --format="%C(bold red)%h%C(reset) %C(bold cyan)<%ar> %C(green)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset)" "$@" |
    fzf --no-sort --reverse --tiebreak=index --no-multi --no-mouse \
    --ansi --preview="$_viewGitLogLine" \
    --bind "enter:execute:$_viewGitLogLine | less -R"
}

complete -F _fzf_path_completion -o default -o bashdefault vim

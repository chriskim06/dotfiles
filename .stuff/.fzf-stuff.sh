#!/usr/bin/env bash

# fzf stuff

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
_fzf_compgen_path() {
  fd --type f --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
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
    read -r -a out <<< "$out"
    sha="${out[0]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    git stash show -p "$sha"
  done
}

fshow() {
  _viewGitLogLine="echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | delta'"
  git log --color=always --format="%C(bold red)%h%C(reset) %C(bold cyan)<%ar> %C(green)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset)" "$@" |
    fzf --no-sort --reverse --tiebreak=index --no-multi --no-mouse \
    --ansi --preview="$_viewGitLogLine" \
    --bind "enter:execute:$_viewGitLogLine | less -R" \
    --bind "J:preview-down" \
    --bind "K:preview-up"
}

complete -F _fzf_path_completion -o default -o bashdefault vim

# easy function for opening a file in vim chosen in an fzf tmux popup
p() {
  local a=$(fzf-tmux -p 80% -- --preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null")
  if [[ -n "$a" ]]; then
    # these escape sequences allow rewriting the command printed to the terminal after
    # running this function
    # - move cursor up one line
    # - move cursor forward 10 columns (fixed width based on length of PS1)
    # - delete from current cursor position to end of line
    # - print the vim command being run followed by a newline
    printf '\e[F\e[10C\e[K%s\n' "vim $a"
    vim "$a"

    # add the vim command being run to the history file
    # p is not added to history via $HISTIGNORE
    history -s "vim $a"
  fi
}

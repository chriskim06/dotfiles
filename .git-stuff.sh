#!/usr/bin/env bash

# Git stuff

# aliases
alias gb='git branch'
alias gd='git branch -D'
alias gf='git fetch --prune'
alias gk='git checkout'
alias gc='git commit'
alias gl='git lg'
alias gs='git number -uall | sed "/^$/d"'
alias gu='git unstage'
alias push='git push'
alias pull='git pull'
alias delete='git delete'
alias discard='git discard'
alias staged='git staged'
alias branches='git branches'

# functions
stash() {
  if [[ $# -eq 0 ]]; then
    git stash list --pretty="%C(bold 227)%gd %C(bold 14)<%ar> %C(bold 15)%gs" | cat
  elif [[ $# -eq 1 && "$1" == "list" ]]; then
    fstash
  elif [[ $# -eq 1 && "$1" == "pop" ]]; then
    git stash pop > /dev/null
    git number -uall | sed "/^$/d"
  else
    git stash $*
  fi
}
ga() {
  if [[ $# -eq 0 ]]; then
    printf "Choose files to stage for commit\n"
  else
    git add $(git list "$@" | sed "s/"$'\E\[1;31m'"//g")
    git number | sed '/(use "git /d' | sed '/^$/d' | sed 1,2d
  fi
}
gconf() {
  if [[ $# -eq 0 ]]; then
    git config --global -e
  else
    git config --global "$@"
  fi
}
vn() {
  [[ $# -eq 1 ]] && vim $(git list "$@" | sed "s/"$'\E\[1;31m'"//g")
}

# completion
# [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[[ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]] && . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
[[ -f ~/bin/completion/git-custom-completion ]] && source ~/bin/completion/git-custom-completion
if command -v __git_complete > /dev/null; then
  __git_complete ga _git_add
  __git_complete gb _git_branch
  __git_complete gd _git_branch
  __git_complete gf _git_fetch
  __git_complete gc _git_commit
  __git_complete gk _git_checkout
  __git_complete gu _git_unstage
  __git_complete gs _git_number
  __git_complete gconf _git_config
  __git_complete stash _git_stash
  __git_complete push _git_push
  __git_complete pull _git_pull
  __git_complete delete _git_delete
  __git_complete discard _git_discard
fi

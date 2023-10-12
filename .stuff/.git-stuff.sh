#!/usr/bin/env bash

# Git stuff

# setup scmpuff
eval "$(scmpuff init --shell=bash --aliases=false)"

# aliases
alias ga='git add'
alias gb='git branch'
alias gd='git branch -D'
alias gk='git checkout'
alias gc='git commit'
alias gl='fshow'
alias gs='scmpuff_status'
alias gac='git add . &>/dev/null && git commit'
alias push='git push'
alias pull='git pull --prune'
alias delete='git delete'
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
    scmpuff_status
  else
    git stash "$@"
  fi
}

discard() {
  if [[ $# -eq 0 ]]; then
    printf "Usage: git discard <file>...\n"
  else
    git checkout -- "$@"
    scmpuff_status
  fi
}

gu() {
  if [[ $# -eq 0 ]]; then
    printf "Usage: git unstage <file>...\n"
  else
    if [[ -n "$(git show-ref --head)" ]]; then
      git reset HEAD "$@" > /dev/null
    else
      git rm -r --cached  "$@" > /dev/null
    fi
    scmpuff_status
  fi
}

gf() {
  if [[ $# -eq 0 ]]; then
    git fetch --all --prune
  else
    git fetch --prune "$@"
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
  [[ $# -eq 1 ]] && vim "$(scmpuff expand "$@")"
}

# completion
[[ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]] && . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
[[ -f "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ]] && . "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
[[ -f ~/bin/completion/git-custom-completion ]] && source ~/bin/completion/git-custom-completion
if command -v __git_complete > /dev/null; then
  __git_complete ga _git_add
  __git_complete gb _git_branch
  #   __git_complete gd _git_branch
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

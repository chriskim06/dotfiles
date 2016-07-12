#
# .bashrc
#

# Initialization {{{1
# Bash completion {{{2
[[ -f $(brew --prefix)/etc/bash_completion ]] && source $(brew --prefix)/etc/bash_completion
# }}}2
# Bash prompt {{{2
bash_prompt () {
  PS1="\[\e[1m\]\[\e[38;5;229m\][\A] \[\e[38;5;33m\]\u\[\e[38;5;15m\]:\[\e[38;5;33m\]\W\[\e[38;5;48m\]\$(__git_ps1) \[\e[38;5;15m\]\$\[\e[0m\] "
}
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; bash_prompt"
# }}}2
# Miscellaneous {{{2
complete -d cd
eval $(thefuck --alias)
shopt -s histappend
# }}}2
# }}}1

# Random functions {{{1
color () { # {{{2
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && echo
  done
  printf "%s\n" '\e[38;5;COLOR_CODEm is a foreground color'
  printf "%s\n" '\e[48;5;COLOR_CODEm is a background color'
  printf "%s\n" '\e[1m is bold and \e[0m ends a sequence'
} # }}}2
= () { # {{{2
  calculator
} # }}}2
man () { # {{{2
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
} # }}}2
# }}}1

# Aliases {{{
alias ag='ag --hidden -p ~/.agignore'
alias vim='mvim -v'
alias vv='vim ~/.vim/vimrc/.vimrc'
alias vimrc='cd ~/.vim/vimrc; pwd; ll'
alias vbashrc='vim ~/config/.bashrc'
alias config='cd ~/config; pwd; ll'
alias soba='source ~/.bashrc'
alias copy='pbcopy'
alias ll='ls -lAh'
alias ssh='ssh -o ServerAliveInterval=60'
alias fhere='find . -iname'
alias work='cd ~/workspace/fastspring-system'
alias clean='rm -r ~/workspace/fastspring-system/out && rm -r ~/workspace/fastspring-system/*/target'
alias manager='~/scripts/go -m'
alias weather='curl http://wttr.in/'
alias ndmon='nodemon'
alias npmlist='npm list -g --depth=0'
alias sslserver='http-server-basicauth-ssl ./ -p 9999 -S -C ~/.ssl/cert.pem -K ~/.ssl/key.pem -c-1 -d'
[[ -f ~/.private ]] && source ~/.private
# }}}

# Git Stuff # {{{1
# Aliases {{{2
alias gb='git branch'
alias gf='git fetch'
alias gk='git checkout'
alias gc='git commit'
alias gl='git lg'
alias gs='git number'
alias gu='git unstage'
alias push='git push'
alias pull='git pull'
alias delete='git delete'
alias discard='git discard'
alias staged='git staged'
# }}}2
# Functions {{{2
stash () { # {{{3
  if [[ $# -eq 0 ]]; then
    local IFS=$'\n'
    for stash in $(git stash list); do
      num=${stash%%: *}
      branch=${stash#*: }
      branch=${branch%%: *}
      msg=${stash##*: }
      printf "\e[1m\e[38;5;227m$num: \e[38;5;14m$branch: \e[38;5;15m$msg\e[0m\n"
    done
  else
    git stash $*
  fi
} # }}}3
ga () { # {{{3
  if [[ $# -eq 0 ]]; then
    echo "Choose files to stage for commit"
  else
    git add $(git list $@ | sed "s/"$'\E\[1;31m'"//g")
    git number | sed '/(use "git /d' | sed '/^$/d' | sed 1,2d
  fi
} # }}}3
gconf () { # {{{3
  if [[ $# -eq 0 ]]; then
    git config --global -e
  else
    git config --global "$@"
  fi
} # }}}3
vn () { # {{{3
    [[ $# -eq 1 ]] && vim $(git list $@ | sed "s/"$'\E\[1;31m'"//g")
} # }}}3
branches () { # {{{3
  while read -r branch; do
    clean_branch_name=${branch//\*\ /}
    description=$(git config branch.$clean_branch_name.description)
    if [[ "${branch::1}" == "*" ]]; then
      printf "* \e[38;5;10m$clean_branch_name\e[0m \e[38;5;252m$description\e[0m\n"
    else
      printf "  $branch \e[38;5;252m$description\e[0m\n"
    fi
  done <<< "$(git branch --list)"
} # }}}3
# }}}2
# Completion {{{2
[[ -f ~/bin/completion/git-custom-completion ]] && source ~/bin/completion/git-custom-completion
__git_complete git _git_completion
__git_complete ga _git_add
__git_complete gb _git_branch
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
# }}}2
# }}}1

# Postgres {{{1
pg () { # {{{2
  if [[ $# -ne 1 || "$1" != "commerce" && "$1" != "postgres" ]]; then
    echo "usage: pg [commerce|postgres]"
  else
    if [[ "$1" == "commerce" ]]; then
      pgcli -h localhost -p 5432 -U sa $1
    elif [[ "$1" == "postgres" ]]; then
      pgcli -h localhost -p 5432 -U postgres $1
    fi
  fi
  return 0
} # }}}2
_pg () { # {{{2
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=($(compgen -W "commerce postgres" -- $cur))
} # }}}2
complete -F _pg pg
# }}}1

# Homebrew stuff {{{1
[[ -f ~/bin/completion/brew-custom-completion ]] && source ~/bin/completion/brew-custom-completion
brew_list () { # {{{2
  printf "\e[1m\e[38;5;15m$(brew list | wc -l | sed 's/^[[:space:]]*//') formulae installed:\e[0m\n"
  brew list | col
} # }}}2
# }}}1

# fzf stuff {{{1
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ $- =~ .*i.* ]] && bind '"\e[Z": "\C-r"'
# Functions {{{2
fd () {
  local current=$(pwd)
  cd "$(find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m)"
  [[ "$(pwd)" != "$current" ]] && pwd
}
fshow () {
  git log --graph --pretty=format:'%C(bold red)%h%C(reset) %C(bold cyan)<%ar> %C(green)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset)' --all |
  fzf --ansi --no-sort --tiebreak=index \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show %') << 'FZF-EOF'
                {}
FZF-EOF"
}
# }}}1


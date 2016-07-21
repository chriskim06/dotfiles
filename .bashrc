#
# .bashrc
#

# Initialization {{{1
# Bash {{{2
[[ -f $(brew --prefix)/etc/bash_completion ]] && source $(brew --prefix)/etc/bash_completion
right=$(printf "\xee\x82\xb0\x0a")
symbol=$(printf "\xee\x82\xa0\x0a")
bash_prompt () {
  prompt=$(__git_ps1 " %s")
  if [[ -z "$prompt" ]]; then
    last="\[\e[0m\]\[\e[38;5;23m\]$right\[\e[0m\]"
  else
    if [[ "$prompt" =~ ^.*\|(MERGING|REBASE).*$ ]]; then
      color=";5;15m"
    elif [[ "$prompt" =~ ^.*-[0-9]*$ ]]; then
      color=";5;196m"
    elif [[ "$prompt" =~ ^.*\+[0-9]*$ ]]; then
      color=";5;34m"
    elif [[ "$prompt" =~ ^.*(%|\*).*$ ]]; then
      color=";5;184m"
    else
      color=";5;42m"
    fi
    last="\[\e[48$color\]\[\e[38;5;23m\]$right\[\e[48$color\]\[\e[38;5;15m\]  $symbol$prompt \[\e[0m\]\[\e[38$color\]$right\[\e[0m\]"
  fi
  PS1="\n\[\e[1m\]\[\e[48;5;30m\]\[\e[38;5;15m\]  \u@\h \[\e[48;5;23m\]\[\e[38;5;30m\]$right\[\e[48;5;23m\]\[\e[38;5;15m\]  \w $last\n\[\e[48;5;32m\]\[\e[38;5;15m\]  \A \[\e[0m\]\[\e[38;5;32m\]$right \[\e[0m\]"
}
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; bash_prompt"
# }}}2
# Miscellaneous {{{2
complete -d cd
eval "$(thefuck --alias)"
shopt -s histappend
# }}}2
# }}}1

# Random functions {{{1
color () { # {{{2
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && printf "\n"
  done
  printf "%s\n" '\e[38;5;COLOR_CODEm is a foreground color'
  printf "%s\n" '\e[48;5;COLOR_CODEm is a background color'
  printf "%s\n" '\e[1m is bold and \e[0m ends a sequence'
} # }}}2
= () { # {{{2
  calculator
} # }}}2
man () { # {{{2
  command man -P "less +Gg" "$@"
} # }}}2
bro () { # {{{2
  if [[ $# -eq 1 && ! "$1" =~ ^help|-h|--help$ ]]; then
    command bro $1 | less -~ +Gg
  else
    command bro -h
  fi
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
alias weather='curl http://wttr.in/'
alias ndmon='nodemon'
alias npmlist='npm list -g --depth=0'
alias cask='brew cask'
# }}}

# Git Stuff # {{{1
# Aliases {{{2
alias gb='git branch'
alias gf='git fetch'
alias gk='git checkout'
alias gc='git commit'
alias gl='git lg'
alias gs='git number -uall | sed "/^$/d"'
alias gu='git unstage'
alias discard='git discard'
alias delete='git delete'
alias push='git push'
alias pull='git pull'
alias staged='git staged'
# }}}2
# Functions {{{2
stash () { # {{{3
  if [[ $# -eq 0 ]]; then
    git stash list --pretty="%C(bold 227)%gd %C(bold 14)<%ar> %C(bold 15)%gs" | cat
  elif [[ $# -eq 1 && "$1" == "list" ]]; then
    fstash
  else
    git stash $*
  fi
} # }}}3
ga () { # {{{3
  if [[ $# -eq 0 ]]; then
    printf "Choose files to stage for commit\n"
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
# }}}2
# }}}1

# Homebrew stuff {{{1
[[ -f ~/bin/completion/brew-custom-completion ]] && source ~/bin/completion/brew-custom-completion
brew_list () { # {{{2
  printf "\e[1m\e[38;5;15m$(brew list | wc -l | sed 's/^[[:space:]]*//') formulae installed:\e[0m\n"
  brew list | col
} # }}}2
brew_random () { # {{{2
  local formulae=($(brew search | grep -v /))
  local desc=$(brew desc "${formulae[$((RANDOM %= ${#formulae[@]}))]}" 2>&1)
  local name=$(printf "$desc" | cut -d: -f1)
  local info=$(printf "$desc" | cut -d: -f2-)
  [[ "$name" != "Error" ]] && printf "Random Homebrew formula\n$name:$info\n" > ~/.random_brew_cmd
}
cat ~/.random_brew_cmd
(brew_random &)
# }}}2
# }}}1

# fzf stuff {{{1
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ $- =~ .*i.* ]] && bind '"\e[Z": "\C-r"'
# Functions {{{2
fshow () { # {{{3
  git log --graph --pretty=format:'%C(bold red)%h%C(reset) %C(bold cyan)<%ar> %C(green)%an%C(reset)%C(bold yellow)%d%C(reset) %C(white)%s%C(reset)' --all |
  fzf --ansi --no-sort --tiebreak=index \
    --bind "ctrl-m:execute:
            (grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show %') << 'FZF-EOF'
            {}
FZF-EOF"
} # }}}3
fstash() { # {{{3
  local out q k sha
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
} # }}}3
# }}}2
# }}}1


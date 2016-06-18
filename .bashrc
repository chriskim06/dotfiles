#
# .bashrc
#

# Color variables {{{
BOLD="$(tput bold)"
END="$(tput sgr0)"
COLORS=()
for i in {0..255}; do
  COLORS+=("$(tput setaf $i)")
done
# }}}

# Initialization {{{1
# Bash completion {{{2
if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
  source $(brew --prefix)/etc/bash_completion
fi
# }}}2
# Bash prompt {{{2
bash_prompt () {
  PS1="\[$BOLD\]\[${COLORS[229]}\][\A] \[${COLORS[33]}\]\u\[${COLORS[15]}\]:\[${COLORS[33]}\]\W\[${COLORS[48]}\]\$(__git_ps1) \[${COLORS[15]}\]\$\[$END\] "
}
export PROMPT_COMMAND=bash_prompt
# }}}2
# Miscellaneous {{{2
complete -d cd
eval $(thefuck --alias)
shopt -s histappend
if [[ $- =~ .*i.* ]]; then
  bind '"\C-r": "\C-a hh \C-j"';
fi
# }}}2
# }}}1

# Random functions {{{1
color () { # {{{2
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    echo -n "$(tput setab $code)  ${COLORS[0]}$val  $END|  ${COLORS[$code]}$val$END  |"
    if [ $((($code + 1) % 8)) -eq 0 ]; then
      echo
    fi
  done
} # }}}2
= () { # {{{2
calculator
} # }}}2
# }}}1

# Aliases {{{
alias ag='ag -p ~/.agignore'
alias vim='mvim -v'
alias vv='mvim -v ~/.vim/vimrc/.vimrc'
alias vimrc='cd ~/.vim/vimrc; pwd; ll'
alias vbashrc='mvim -v ~/config/.bashrc'
alias config='cd ~/config; pwd; ll'
alias soba='source ~/.bashrc'
alias copy='pbcopy'
alias ll='ls -lAh'
alias ssh='ssh -o ServerAliveInterval=60'
alias fhere='find . -iname'
alias work='cd ~/workspace/fastspring-system'
alias clean='rm -r out && rm -r */target'
alias manager='~/scripts/go -m'
alias weather='curl http://wttr.in/'
alias sslserver='http-server-basicauth-ssl ./ -p 9999 -S -C ~/.ssl/cert.pem -K ~/.ssl/key.pem -c-1 -d'
# }}}

# Git Stuff # {{{1
# Aliases {{{2
alias g='git'
alias gb='git branch'
alias gf='git fetch'
alias gk='git checkout'
alias gc='git commit'
alias gl='git lg'
alias gn='git number'
alias gs='git number'
alias gu='git unstage'
alias push='git push'
alias pull='git pull'
alias merge='git fetch; git merge'
alias delete='git delete'
alias discard='git discard'
alias feature='git feature'
# }}}2

# Functions {{{2
stash () { # {{{3
  if [[ $# -eq 0 || $# -eq 1 && "$1" == "list" ]]; then
    list=$(git stash list)
    if [[ -z "$list" ]]; then
      echo "No saved stashes. To save a stash use 'gstash save <message>'"
      return 0
    fi
    local IFS=$'\n'
    for stash in $list; do
      num=${stash%%: *}
      branch=${stash#*: }
      branch=${branch%%: *}
      msg=${stash##*: }
      echo "$BOLD${COLORS[227]}$num: ${COLORS[14]}$branch: ${COLORS[15]}$msg$END"
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
    echo
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
  if [[ $# -eq 0 ]]; then
    echo "Choose a file to edit"
  else
    mvim -v $(git list $@ | sed "s/"$'\E\[1;31m'"//g")
  fi
} # }}}3
branches () { # {{{3
  while read -r branch; do
    clean_branch_name=${branch//\*\ /}
    description=$(git config branch.$clean_branch_name.description)
    if [[ "${branch::1}" == "*" ]]; then
      printf "* ${COLORS[10]}$clean_branch_name$END ${COLORS[252]}$description$END\n"
    else
      printf "  $branch ${COLORS[252]}$description$END\n"
    fi
  done <<< "$(git branch --list)"
} # }}}3
# }}}2

# Completion {{{2
if [[ -f ~/bin/completion/git-custom-completion ]]; then
  source ~/bin/completion/git-custom-completion
fi
__git_complete g _git_completion
__git_complete git _git_completion
__git_complete ga _git_add
__git_complete gb _git_branch
__git_complete gf _git_fetch
__git_complete gc _git_commit
__git_complete gk _git_checkout
__git_complete gu _git_unstage
__git_complete gn _git_number
__git_complete gs _git_number
__git_complete gconf _git_config
__git_complete stash _git_stash
__git_complete push _git_push
__git_complete pull _git_pull
__git_complete merge _git_merge
__git_complete delete _git_delete
# }}}2
# }}}1

# Node Stuff {{{1
alias ndmon='nodemon'
alias npmlist='npm list -g --depth=0'
# }}}1

# Postgres {{{1
pg () { # {{{2
  if [ $# -ne 1 ] || [ "$1" != "commerce" ] && [ "$1" != "postgres" ]; then
    echo "usage: pg [commerce|postgres]"
  else
    "/Library/PostgreSQL/9.4/bin/psql" -h localhost -p 5432 -U postgres $1
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
if [[ -f ~/bin/completion/brew-custom-completion ]]; then
  source ~/bin/completion/brew-custom-completion
fi
brew_list () { # {{{2
  formulae=($(brew list))
  echo "$BOLD${COLORS[15]}${#formulae[@]} formulae installed:$END"
  for i in "${formulae[@]}"; do
    echo "$i"
  done
} # }}}2
brew_random () { # {{{2
  local formula=$(brew search | grep -v / | gshuf | head -n 1)
  local desc=$(brew desc "${formula}" 2>&1)
  local name=$(echo "$desc" | cut -d: -f1)
  local info=$(echo "$desc" | cut -d: -f2-)
  if [[ "$name" != "Error" ]]; then
    echo -e "${COLORS[15]}Random Homebrew formula:$END" > ~/.random_brew_cmd
    echo -e "${COLORS[45]}$name:$END $info" >> ~/.random_brew_cmd
    echo "" >> ~/.random_brew_cmd
  fi
}
cat ~/.random_brew_cmd
brew_random &
# }}}2
# }}}1


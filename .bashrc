#
# .bashrc
#

# tmux
tmux new-session -A -s main 2>/dev/null

# Initialization {{{1
# Bash {{{2
# [[ -f "$(brew --prefix)/etc/bash_completion" ]] && source "$(brew --prefix)/etc/bash_completion"
bash_prompt () {
  # Remember to install powerline fonts
  local e='\e[0m'
  local b='\e[48;5;'
  local f='\e[38;5;'
  local arrow=$'\ue0b0'
  local prompt=$(__git_ps1 " %s")
  if [[ -z "$prompt" ]]; then
    local last="\[$e\]\[${f}23m\]$arrow\[$e\]"
  else
    local color="42m"
    if [[ "$prompt" =~ ^.*\|(MERGING|REBASE).*$ ]]; then
      color="165m"
    elif [[ "$prompt" =~ ^.*-[0-9]*$ ]]; then
      color="196m"
    elif [[ "$prompt" =~ ^.*\+[0-9]*$ ]]; then
      color="75m"
    elif [[ "$prompt" =~ ^.*(%|\*).*$ ]]; then
      color="184m"
    fi
    local branch=$'\ue0a0'
    # local branch=$'\u2387'
    local last="\[${b}$color\]\[${f}23m\]$arrow\[${b}$color\]\[${f}15m\]  $branch$prompt \[$e\]\[${f}$color\]$arrow\[$e\]"
  fi
  PS1="\n\[\e[1m\]\[${b}30m\]\[${f}15m\]  \u@\h \[${b}23m\]\[${f}30m\]$arrow\[${b}23m\]\[${f}15m\]  \w $last\n\[${b}32m\]\[${f}15m\]  \A \[$e\]\[${f}32m\]$arrow \[$e\]"
}
export PROMPT_COMMAND="history -n; history -w; history -c; history -r; bash_prompt"
# }}}2
# Miscellaneous {{{2
complete -d cd
eval "$(thefuck --alias)"
shopt -s histappend

if command -v bat >/dev/null; then
  BAT_PATH=$(which bat)
  function bat() {
    $BAT_PATH --color always --theme=TwoDark --paging never "$@" | less
  }
fi
complete -o default -F _fzf_path_completion bat

color () { # {{{2
  printf "%s\n" '\e[38;5;COLOR_CODEm is a foreground color'
  printf "%s\n" '\e[48;5;COLOR_CODEm is a background color'
  printf "%s\n" '\e[1m is bold and \e[0m ends a sequence'
  local val
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && printf "\n"
  done
} # }}}2

bind '"\C-l": forward-word'
bind '"\C-h": backward-word'
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'
bind '"\e[1;3A": beginning-of-line'
bind '"\e[1;3B": end-of-line'
# }}}2
# }}}1

# Aliases {{{
alias ls='ls --color=auto'
alias ag='ag --hidden -p ~/.ignore'
alias rg='rg --smart-case --hidden'
alias vi='nvim'
alias vim='nvim'
alias vv='vim ~/src/dotfiles/vim/.vimrc'
alias vimfiles='cd ~/src/dotfiles/vim; pwd; ll'
alias vbashrc='vim ~/src/dotfiles/.bashrc'
alias config='cd ~/src/dotfiles; pwd; ll'
alias fuck='fuck --yeah'
alias soba='source ~/.bashrc'
alias dk='docker'
alias dkc='docker-compose'
alias dkcnc='docker-compose build --pull --no-cache'
alias brwe='brew'
alias ll='ls -lAh'
alias shit='sudo $(history -p \!\!)'
alias ssh='ssh -o ServerAliveInterval=60'
alias fhere='find . -iname'
alias weather='curl http://wttr.in/oakland'
alias starwars='telnet towel.blinkenlights.nl'
alias work='cd ~/src/work; ll'
alias gowork=' cd ~/go/src/git.ask.com; ll'
alias feat='git feature'
alias npmlist='npm list -g --depth=0'
alias prune='docker system prune -af'
alias tree='tree -a -I "\.git|node_modules"'
alias kc='kubectl'
complete -F __start_kubectl kc
[[ -f ~/.private ]] && source ~/.private
# }}}

# Git stuff {{{1
# Aliases {{{2
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
# }}}2
# Functions {{{2
stash () { # {{{3
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
} # }}}3
ga () { # {{{3
  if [[ $# -eq 0 ]]; then
    printf "Choose files to stage for commit\n"
  else
    git add $(git list "$@" | sed "s/"$'\E\[1;31m'"//g")
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
  [[ $# -eq 1 ]] && vim $(git list "$@" | sed "s/"$'\E\[1;31m'"//g")
} # }}}3
# }}}2
# Completion {{{2
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[[ -f "$(brew --prefix)/Cellar/git/2.20.1/etc/bash_completion.d/git-completion.bash" ]] && . "$(brew --prefix)/Cellar/git/2.20.1/etc/bash_completion.d/git-completion.bash"
[[ -f ~/bin/completion/git-custom-completion ]] && source ~/bin/completion/git-custom-completion
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
# }}}2
# }}}1

# fzf stuff {{{1
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
fshow () { # {{{2
  local d="$(date -v-1y +%F)"
  git lg --since=\{"$d"\} | fzf --ansi --no-sort --tiebreak=index --bind "enter:execute:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show %')"
} # }}}2
fstash() { # {{{2
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
} # }}}2
complete -F _fzf_path_completion -o default -o bashdefault vim
# }}}1

# linuxbrew {{{1
brew_random () {
  if [[ -n "$(type -t cowsay)" ]]; then
    cat ~/.random_brew_cmd 2>/dev/null
    local formulae=($(brew search | grep -v /))
    local desc=$(brew desc "${formulae[$((RANDOM % ${#formulae[@]}))]}" 2>/dev/null)
    [[ $? -eq 0 ]] && cowsay "$desc" > ~/.random_brew_cmd
  fi
}
(brew_random &)
# }}}1

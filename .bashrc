#
# .bashrc
#

# tmux
tmux new-session -A -s main 2>/dev/null

# Initialization {{{1
# Bash {{{2
bash_prompt() {
  # Remember to install powerline fonts
  local e='\e[0m'
  local b='\e[48;5;'
  local f='\e[38;5;'
  local arrow=$'\ue0b0'
  local prompt=$(__git_ps1 " %s")
  if [[ -z "$prompt" ]]; then
    local last="\[$e\]\[${f}23m\]$arrow\[$e\]"
  else
    local color="42m" # green
    if [[ "$prompt" =~ ^.*\|(MERGING|REBASE).*$ ]]; then
      color="165m" # purple
    elif [[ "$prompt" =~ ^.*-[0-9]*$ ]]; then
      color="196m" # red
    elif [[ "$prompt" =~ ^.*\+[0-9]*$ ]]; then
      color="75m" # light blue
    elif [[ "$prompt" =~ ^.*\+.*$ ]]; then
      color="73m" # grayish blue
    elif [[ "$prompt" =~ ^.*(%|\*).*$ ]]; then
      color="179m" # orange
    fi
    local branch=$'\ue0a0'
    # local branch=$'\u2387'
    local last="\[${b}$color\]\[${f}23m\]$arrow\[${b}$color\]\[${f}15m\]  $branch$prompt \[$e\]\[${f}$color\]$arrow\[$e\]"
  fi
  PS1="\n\[\e[1m\]\[${b}30m\]\[${f}15m\]  \u@\h \[${b}23m\]\[${f}30m\]$arrow\[${b}23m\]\[${f}15m\]  \w $last\n\[${b}32m\]\[${f}15m\]  \A \[$e\]\[${f}32m\]$arrow \[$e\]"
}
export PROMPT_COMMAND="history -a; history -c; history -r; bash_prompt"
# }}}2
# Miscellaneous {{{2
complete -d cd
eval "$(thefuck --alias)"
shopt -s histappend

bind '"\C-l": forward-word'
bind '"\C-h": backward-word'
bind '"\C-d": backward-kill-word'
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'
bind '"\e[1;3A": beginning-of-line'
bind '"\e[1;3B": end-of-line'

if command -v bat >/dev/null; then
  BAT_PATH=$(which bat)
  function bat() {
    $BAT_PATH --color always --theme=TwoDark --paging never "$@" | less
  }
fi
complete -o default -F _fzf_path_completion bat

color() { # {{{3
  printf "%s\n" '\e[38;5;COLOR_CODEm is a foreground color'
  printf "%s\n" '\e[48;5;COLOR_CODEm is a background color'
  printf "%s\n" '\e[1m is bold and \e[0m ends a sequence'
  local val
  for code in {0..255}; do
    val="$(printf '%03d' $code)"
    printf "\e[48;5;${code}m  \e[38;5;0m$val  \e[0m|  \e[38;5;${code}m$val\e[0m  |"
    [[ $((($code + 1) % 8)) -eq 0 ]] && printf "\n"
  done
} # }}}3

b64() { # {{{3
  printf "%s" "$@" | base64 -w 0
  echo
} # }}}3

brew_random() {
  if [[ -n "$(type -t cowsay)" ]]; then
    cat ~/.random_brew_cmd 2>/dev/null
    local formulae=($(brew search | grep -v /))
    local desc=$(brew desc "${formulae[$((RANDOM % ${#formulae[@]}))]}" 2>/dev/null)
    [[ $? -eq 0 ]] && cowsay "$desc" > ~/.random_brew_cmd
  fi
}
(brew_random &)
# }}}2
# }}}1

# Load other stuff {{{
[[ -f ~/.aliases.sh ]] && source ~/.aliases.sh
[[ -f ~/.git-stuff.sh ]] && source ~/.git-stuff.sh
[[ -f ~/.fzf-stuff.sh ]] && source ~/.fzf-stuff.sh
[[ -f ~/.private ]] && source ~/.private
# }}}

source <(kubectl completion bash)
complete -F __start_kubectl kc
[[ -f ~/bin/completion/kubectl-custom-completion ]] && source ~/bin/completion/kubectl-custom-completion

# this is used to map caps lock to ctrl/escape on linux
if [[ "$OSTYPE" == "linux-gnu" && -n "$(command -v setxkbmap)" && -n "$(command -v xcape)" ]]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e '#66=Escape'
fi

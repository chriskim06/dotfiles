#
# .bashrc
#

# fixes scp problem
[[ -z "$PS1" ]] && return

# tmux
tmux new-session -A -s main 2>/dev/null

# custom prompt
bash_prompt() {
  # Remember to install powerline fonts
  local os="$(uname)"
  local e='\e[0m'
  local b='\e[48;5;'
  local f='\e[38;5;'
#   local arrow=''
  local arrow=$'\ue0b0'
  if [[ "$os" == "Darwin" ]]; then
    arrow="$(echo -e '\ue0b0')"
  fi
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
#     local branch=''
    local branch=$'\ue0a0'
    if [[ "$os" == "Darwin" ]]; then
      branch="$(echo -e '\ue0a0')"
    fi
    local last="\[${b}$color\]\[${f}23m\]$arrow\[${b}$color\]\[${f}15m\]  $branch$prompt \[$e\]\[${f}$color\]$arrow\[$e\]"
  fi
  local line1="\n\[\e[1m\]\[${b}30m\]\[${f}15m\]  \u@not-computer \[${b}23m\]\[${f}30m\]$arrow\[${b}23m\]\[${f}15m\]  \w $last"
  local line2="\n\[${b}32m\]\[${f}15m\]  \A \[$e\]\[${f}32m\]$arrow \[$e\]"
  PS1="${line1}${line2}"
}
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND="history -a; history -c; history -r; bash_prompt"

# miscellaneous
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

# other stuff
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[[ -f ~/.aliases.sh ]] && source ~/.aliases.sh
[[ -f ~/.functions.sh ]] && source ~/.functions.sh
[[ -f ~/.git-stuff.sh ]] && source ~/.git-stuff.sh
[[ -f ~/.fzf-stuff.sh ]] && source ~/.fzf-stuff.sh
[[ -f ~/.local-aliases.sh ]] && source ~/.local-aliases.sh
[[ -f ~/.private ]] && source ~/.private
[[ -f ~/.local-aliases.sh ]] && source ~/.local-aliases.sh

# kubectl stuff
source <(kubectl completion bash)
complete -F __start_kubectl k
[[ -f ~/bin/completion/kubectl-custom-completion ]] && source ~/bin/completion/kubectl-custom-completion

# this is used to map caps lock to ctrl/escape on linux
if [[ "$OSTYPE" == "linux-gnu" && -n "$(command -v setxkbmap)" && -n "$(command -v xcape)" ]]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e '#66=Escape'
fi

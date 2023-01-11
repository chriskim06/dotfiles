#
# .bashrc
#

# fixes scp problem
[[ -z "$PS1" ]] && return

# tmux
tmux new-session -A -s main 2>/dev/null

# custom prompt
ANSI_ESC=$'\033'
ANSI_CSI="${ANSI_ESC}["
_ansi_bg() {
  printf '%s48;5;%sm' "$ANSI_CSI" "$1"
}
_ansi_fg() {
  printf '%s38;5;%sm' "$ANSI_CSI" "$1"
}
_ansi_bold() {
  printf '%s1m' "$ANSI_CSI"
}
_ansi_reset() {
  printf '%s0m' "$ANSI_CSI"
}
bash_prompt() {
  # Remember to install powerline fonts
  local arrow=''
  local char_color="$(_ansi_fg 15)"
  local prompt=$(__git_ps1 " %s")
  if [[ -z "$prompt" ]]; then
    local last="$(_ansi_reset)$(_ansi_fg 23)${arrow}$(_ansi_reset)"
  else
    local color="42" # green
    if [[ "$prompt" =~ ^.*\|(MERGING|REBASE).*$ ]]; then
      color="165" # purple
    elif [[ "$prompt" =~ ^.*-[0-9]*$ ]]; then
      color="196" # red
    elif [[ "$prompt" =~ ^.*\+[0-9]*$ ]]; then
      color="75" # light blue
    elif [[ "$prompt" =~ ^.*\+.*$ ]]; then
      color="73" # grayish blue
    elif [[ "$prompt" =~ ^.*(%|\*).*$ ]]; then
      color="179" # orange
    fi
    local branch=''
    local last="$(_ansi_bg $color)$(_ansi_fg 23)${arrow}$(_ansi_bg $color)${char_color}  ${branch}${prompt} $(_ansi_reset)$(_ansi_fg $color)${arrow}$(_ansi_reset)"
  fi

  local aws_session_expiration=''
  if [[ -n "$AWS_SESSION_EXPIRATION" ]]; then
    aws_session_expiration=" ($(date --date="$AWS_SESSION_EXPIRATION" +%H:%M))"
  fi
  local line1="\n$(_ansi_reset)$(_ansi_bold)$(_ansi_bg 30)${char_color}  \u@not-computer${aws_session_expiration} $(_ansi_bg 23)$(_ansi_fg 30)${arrow}$(_ansi_bg 23)${char_color}  \w ${last}"
  local line2="\n$(_ansi_bg 32)${char_color}  \A $(_ansi_reset)$(_ansi_fg 32)${arrow} $(_ansi_reset)"

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
bind '"\C-j": end-of-line'
bind '"\C-k": beginning-of-line'
bind '"\C-d": backward-kill-word'
# bind '"\e[1;3C": forward-word'
# bind '"\e[1;3D": backward-word'
# bind '"\e[1;3A": beginning-of-line'
# bind '"\e[1;3B": end-of-line'

# other stuff
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
[[ -f ~/.aliases.sh ]] && source ~/.aliases.sh
[[ -f ~/.git-stuff.sh ]] && source ~/.git-stuff.sh
[[ -f ~/.functions.sh ]] && source ~/.functions.sh
[[ -f ~/.fzf-stuff.sh ]] && source ~/.fzf-stuff.sh
[[ -f ~/.local-aliases.sh ]] && source ~/.local-aliases.sh
[[ -f ~/.private ]] && source ~/.private

# kubectl stuff
mkdir -p ~/.local/share/bash_completion
[[ ! -f "~/.local/share/bash_completion/kubectl" ]] && kubectl completion bash > ~/.local/share/bash_completion/kubectl
source ~/.local/share/bash_completion/kubectl
complete -o default -F __start_kubectl k
[[ -f ~/bin/completion/kubectl-custom-completion ]] && source ~/bin/completion/kubectl-custom-completion

# this is used to map caps lock to ctrl/escape on linux
if [[ "$OSTYPE" == "linux-gnu" && -n "$(command -v setxkbmap)" && -n "$(command -v xcape)" ]]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e '#66=Escape'
fi

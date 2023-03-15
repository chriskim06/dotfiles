#
# .bashrc
#

# fixes scp problem
[[ -z "$PS1" ]] && return

# tmux
tmux new-session -A -s main 2>/dev/null

# custom prompt
source ~/.prompt.sh

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
[[ -f ~/.private ]] && source ~/.private

# kubectl stuff
mkdir -p "$HOME/.local/share/bash_completion"
[[ ! -f "$HOME/.local/share/bash_completion/kubectl" ]] && kubectl completion bash > "$HOME/.local/share/bash_completion/kubectl"
source ~/.local/share/bash_completion/kubectl
complete -o default -F __start_kubectl k
[[ -f "$HOME/bin/completion/kubectl-custom-completion" ]] && source "$HOME/bin/completion/kubectl-custom-completion"

# this is used to map caps lock to ctrl/escape on linux
if [[ "$OSTYPE" == "linux-gnu" && -n "$(command -v setxkbmap)" && -n "$(command -v xcape)" ]]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e '#66=Escape'
fi

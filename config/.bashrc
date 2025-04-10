#
# .bashrc
#

# fixes scp problem
[[ -z "$PS1" ]] && return

# tmux
tmux new-session -A -s main 2>/dev/null

# custom prompt
source ~/.stuff/.prompt.sh

# miscellaneous
complete -d cd
eval "$(thefuck --alias)"

# other stuff
prefix="$(brew --prefix)"
[[ -r "${prefix}/etc/profile.d/bash_completion.sh" ]] && source "${prefix}/etc/profile.d/bash_completion.sh"
[[ -f ~/.stuff/.aliases.sh ]] && source ~/.stuff/.aliases.sh
[[ -f ~/.stuff/.git-stuff.sh ]] && source ~/.stuff/.git-stuff.sh
[[ -f ~/.stuff/.functions.sh ]] && source ~/.stuff/.functions.sh
[[ -f ~/.stuff/.fzf-stuff.sh ]] && source ~/.stuff/.fzf-stuff.sh
[[ -f ~/.private ]] && source ~/.private

# kubectl stuff
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
[[ -f "$HOME/bin/completion/kubectl-custom-completion" ]] && source "$HOME/bin/completion/kubectl-custom-completion"

# this is used to map caps lock to ctrl/escape on linux
if [[ "$OSTYPE" == "linux-gnu" && -n "$(command -v setxkbmap)" && -n "$(command -v xcape)" ]]; then
  setxkbmap -option 'caps:ctrl_modifier'
  xcape -e '#66=Escape'
fi

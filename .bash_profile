#
# .bash_profile
#

# Environment variables
PATH=$(getconf PATH)
PATH="/usr/local/bin:$HOME/bin:${GOPATH//://bin:}/bin:$HOME/.krew/bin:$PATH"
if [[ "$(uname)" == "Darwin" ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
fi
if [[ "$(uname)" == Linux ]]; then
  PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
fi
export PATH="$PATH"
export GOPATH="$HOME/go"
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM='verbose git'
export GIT_PS1_STATESEPARATOR=': '
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_HIDE_IF_PWD_IGNORED=1
export CLICOLOR=1
export HISTSIZE=500
export HISTFILESIZE=500
export HISTCONTROL=ignoreboth:erasedups
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;38;5;49m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;48;5;128m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;38;5;11m")
export LESS='-KRSgis -j4 -#4 -P [?f%f:stdin.] ?lt?lbLines %lt-%lb..?L (%L).'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude ".git/*" --exclude "*.swp"'
export FZF_DEFAULT_OPTS='--reverse --bind=tab:down,btab:up --color=fg:-1,bg:-1,hl:24,fg+:254,bg+:239,hl+:33,info:136,prompt:136,pointer:230,marker:230,spinner:136'
export FZF_COMPLETION_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null"'
export FZF_COMPLETION_TRIGGER='jj'
export THEFUCK_WAIT_COMMAND=3
export THEFUCK_HISTORY_LIMIT='200'
export BASH_SILENCE_DEPRECATION_WARNING=1

# Load private environment variables such as secrets/tokens
[[ -f $HOME/.private ]] && source $HOME/.private

# Load .bashrc
[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc

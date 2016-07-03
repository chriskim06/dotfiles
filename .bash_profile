#
# .bash_profile
#

# Environment variables
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export M2_HOME=/usr/local/Cellar/maven/3.3.9/libexec
export M2=M2_HOME/bin
export PATH=$PATH:$M2:$HOME/.node/bin:$HOME/bin
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM='verbose git'
export GIT_PS1_STATESEPARATOR=': '
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_HIDE_IF_PWD_IGNORED=1
export CLICOLOR=1
export LSCOLORS=GxFxExdxbxBxegedabagGxGx
export HISTSIZE=1000
export HISTFILESIZE=1000
export HISTCONTROL=ignoreboth:erasedups
export FZF_DEFAULT_OPTS='--reverse --color=hl:33,hl+:33,bg+:240 --sync --bind=tab:down,btab:up'
export LESS=

# Load .bashrc
if [[ -f $HOME/.bashrc ]]; then
    source $HOME/.bashrc
fi


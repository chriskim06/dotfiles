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

# Initialization {{{
bash_prompt () {
    PS1="\[$BOLD\]\[${COLORS[229]}\][\A] \[${COLORS[33]}\]\u\[${COLORS[15]}\]:\[${COLORS[33]}\]\W\[${COLORS[48]}\]\$(__git_ps1) \[${COLORS[15]}\]\$\[$END\] "
}
export PROMPT_COMMAND=bash_prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM='verbose git'
export GIT_PS1_STATESEPARATOR=': '
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_HIDE_IF_PWD_IGNORED=1
export CLICOLOR=1
export LSCOLORS=GxFxExdxbxBxegedabagGxGx
export HISTSIZE=750
export HISTFILESIZE=750
export HISTCONTROL=ignoredups:erasedups
export LESS=
complete -d cd
# }}}

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
alias vbashrc='mvim -v ~/.bashrc'
alias soba='source ~/.bashrc'
alias copy='pbcopy'
alias ll='ls -lAh'
alias ssh='ssh -o ServerAliveInterval=60'
alias fhere='find . -iname'
alias brwe='brew'
# }}}

# Git Stuff # {{{1

# Aliases {{{2
alias g='git'
alias gb='git branch'
alias gf='git fetch'
alias gk='git checkout'
alias gc='git commit'
alias gm='git merge'
alias gl='git lg'
alias gn='git number'
alias gs='git number'
alias gu='git unstage'
alias discard='git discard'
alias delete='git delete'
alias push='git push'
alias pull='git pull'
# }}}2

# Functions {{{2
gstash () { # {{{3
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
gfrom () { # {{{3
    if [[ $# -ne 1 ]]; then
        echo "Provide a branch to check"
        return 0
    fi
    ancestor=$(diff -u <(git rev-list --first-parent $1) <(git rev-list --first-parent origin/master) | sed -ne 's/^ //p' | head -1)
    master=$(git log -1 --pretty=oneline origin/master | sed -E "s/^([^[:space:]]+).*/\1/")
    originmaster=$(git br -r --contains $master | grep "origin/master")
    branchpoint=$(git br -r --contains $ancestor | grep "origin/master")
    if ! [[ -z "$originmaster" || -z "$branchpoint" ]]; then
        echo "$1 branched off $BOLD${COLORS[40]}origin/master$END"
    else
        echo "$BOLD${COLORS[9]}$1 did not branch off origin/master$END"
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
# }}}2

# Completion {{{2
if [ -f ~/bin/completion/git-custom-completion ]; then
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
__git_complete gstash _git_stash
__git_complete gconf _git_config
__git_complete gfrom _git_branch
__git_complete push _git_push
__git_complete pull _git_pull
__git_complete delete _git_delete
# }}}2

# }}}1

# Node Stuff {{{1
alias ndmon='nodemon'
alias npmlist='npm list -g --depth=0'
# }}}1

# Homebrew stuff {{{1

if [ -f ~/bin/completion/brew-custom-completion ]; then
    source ~/bin/completion/brew-custom-completion
fi
brew_list () { # {{{2
    echo "$BOLD${COLORS[15]}$(brew list | wc -l | cut -c7-) formulae installed:$END"
    brew list
} # }}}2

#} # }}}2

# }}}1


#!/usr/bin/env bash

# Aliases

alias rg='rg --smart-case --hidden'
alias fd='fd --hidden --exclude ".git/*"'
alias vv='vim ~/src/dotfiles/.vimrc'
alias vimfiles='cd ~/src/dotfiles/.vim; pwd; ll'
alias vbashrc='vim ~/src/dotfiles/.bashrc'
alias config='cd ~/src/dotfiles; pwd; ll'
alias dotfiles='cd ~/src/dotfiles; pwd; ll'
alias chriskim06='cd ~/src/chriskim06; pwd; ll'
alias fuck='fuck --yeah'
alias soba='source ~/.bash_profile'
alias dk='docker'
alias dkc='docker-compose'
alias dkcnc='docker-compose build --pull --no-cache'
alias brwe='brew'
alias ls='ls --color=always'
alias ll='ls -lAh'
alias shit='sudo $(history -p \!\!)'
alias ssh='ssh -o ServerAliveInterval=60'
alias fhere='find . -iname'
alias weather='curl http://wttr.in/oakland'
alias starwars='telnet towel.blinkenlights.nl'
alias work='cd ~/src/work; ll'
alias feat='git feature'
alias npmlist='npm list -g --depth=0'
alias prune='docker system prune -af'
alias tree='tree -a -I "\.git|node_modules|vendor"'
alias vrc='vim "+set ft=rest"'
alias k='kubectl'
alias krew='kubectl krew'
alias tkrew='go clean -testcache && hack/make-binary.sh && hack/run-integration-tests.sh && hack/run-tests.sh'
alias ns='kubectl ns'
alias ctx='kubectl ctx'
alias av='aws-vault'
alias tf='terraform'
alias notes="vim +'source ~/.vim/sessions/notes'"
alias sessions="vim +'Workspaces'"
alias scratch='vim +noswapfile +"setlocal buftype=nofile" +"setlocal bufhidden=hide"'

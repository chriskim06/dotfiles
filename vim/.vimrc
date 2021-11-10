"
" Author:       Chris Kim
" Description:  Simple vimrc file that contains a list of plugins I use,
"               autocommands, highlight settings, options, and mappings.
"

" check for vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug management {{{
call plug#begin('~/.vim/bundle')

" Useful
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'burntsushi/ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'henrik/vim-indexed-search'
Plug 'conradirwin/vim-bracketed-paste'
Plug 'junegunn/gv.vim'
Plug 'diepm/vim-rest-console'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'zivyangll/git-blame.vim'

" Languages
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Style
Plug 'morhetz/gruvbox'
Plug 'franbach/miramare'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
" }}}

" Configurations {{{
runtime config/autocmd.vim
runtime config/options.vim
runtime config/plugins.vim
runtime config/mappings.vim
runtime config/colors.vim
runtime config/functions.vim
" }}}

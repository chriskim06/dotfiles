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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'preservim/vim-indent-guides'
Plug 'godlygeek/tabular' " must come before vim-markdown
Plug 'preservim/vim-markdown'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'burntsushi/ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'craigemery/vim-autotag'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'henrik/vim-indexed-search'
Plug 'conradirwin/vim-bracketed-paste'
Plug 'junegunn/gv.vim'
Plug 'diepm/vim-rest-console'
Plug 'zivyangll/git-blame.vim'
Plug 'jreybert/vimagit'
Plug 'franbach/miramare'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'

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

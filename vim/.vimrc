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
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'craigemery/vim-autotag'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'henrik/vim-indexed-search'
Plug 'conradirwin/vim-bracketed-paste'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'diepm/vim-rest-console'

" Languages
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Style
Plug 'morhetz/gruvbox'
Plug 'franbach/miramare'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()
" }}}

" Autocommand Settings {{{
if has('autocmd')
  augroup Files
    au FileType * set formatoptions-=cro
  augroup END
  augroup Buffer
    au BufWritePost,BufWinLeave,BufLeave,WinLeave ?* if &ft != 'help' && &ft != 'fzf' | mkview! | endif
    au BufWinEnter,BufEnter ?* if &ft != 'help' && &ft != 'fzf' | silent! loadview | execute "AirlineRefresh" | endif
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  augroup END
  augroup Folding
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  augroup END
  augroup Ask
    au BufNewFile,BufRead *.src set ft=sh
    au BufNewFile,BufRead Dockerfile.* set ft=dockerfile
  augroup END
endif
" }}}

" Configurations {{{
runtime! config/options.vim
runtime! config/plugins.vim
runtime! config/mappings.vim
runtime! config/colors.vim
" }}}

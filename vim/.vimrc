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
Plug 'junegunn/fzf'
Plug 'jremmen/vim-ripgrep'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'craigemery/vim-autotag'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Languages
Plug 'neoclide/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'othree/javascript-libraries-syntax.vim'

" Style
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'

" Miscellaneous
Plug 'airblade/vim-rooter'
Plug 'henrik/vim-indexed-search'
Plug 'conradirwin/vim-bracketed-paste'

call plug#end()
" }}}

" Autocommand Settings {{{
if has('autocmd')
  augroup Buffer
    au BufWritePost,BufWinLeave,BufLeave,WinLeave ?* if &ft != 'help' && &ft != 'fzf' | mkview! | endif
    au BufWinEnter,BufEnter ?* if &ft != 'help' && &ft != 'fzf' | silent! loadview | execute "AirlineRefresh" | endif
  augroup END
  augroup Folding
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  augroup END
endif
" }}}

" Configurations {{{
runtime! config/colors.vim
runtime! config/options.vim
runtime! config/plugins.vim
runtime! config/mappings.vim
" }}}

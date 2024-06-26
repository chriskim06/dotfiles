"
" Author:      Chris Kim
" Description: Custom key mappings
"

" Useful and Random mappings {{{
map ; :
noremap <cr> G
nnoremap <leader>v :source ~/.vimrc<cr>
nnoremap <silent> Q :call CloseBuffer()<cr>
nnoremap <silent> W :%s/\s\+$//ge<cr>:w<cr>
nnoremap r <c-r>
nnoremap <ScrollWheelUp> <c-y>
nnoremap <ScrollWheelDown> <c-e>
nnoremap p ]p
nnoremap ]p p
nnoremap <c-p> P
nnoremap <silent> ~ mZ~`Z:delm Z<cr>
nnoremap <silent> U mZgUiw`Z:delm Z<cr>
nnoremap <silent> <space> @=(foldlevel('.') ? 'za' : "\<space>")<cr>
nnoremap <silent> L :noh \| echo<cr>
nnoremap + <c-a>
nnoremap - <c-x>
nnoremap v <c-v>
nnoremap V v
nnoremap <c-v> V
nnoremap <silent> Y "*dd
nnoremap d "_d
nnoremap x "_x
vnoremap c "_c
vnoremap d "_d
vnoremap y ygv
vnoremap p P
vnoremap L g<c-g>
vnoremap / y/<c-r>"<cr>
vnoremap < <gv
vnoremap > >gv
command Json %!jq .
" }}}

" Buffer, tab, split mappings {{{
nnoremap <silent> <tab> :bn<cr>
nnoremap <silent> <s-tab> :bp<cr>
nnoremap <silent> <expr> <leader>[ (tabpagenr() == 1) ? ":tabm\<cr>" : ":-tabm\<cr>"
nnoremap <silent> <expr> <leader>] (tabpagenr() == tabpagenr('$')) ? ":0tabm\<cr>" : ":+tabm\<cr>"
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" }}}

" Command line and some insert mappings {{{
inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$
inoremap <c-b> <c-o>b
inoremap <c-f> <c-o>w
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-d> <c-w>
cnoremap ~~ <c-r>"
" }}}

" Movement commands {{{
noremap B ^
noremap E $
nnoremap j gj
nnoremap k gk
nnoremap gg gg0
nnoremap <silent> H :h <c-r><c-w><cr>
vnoremap <silent> H <esc>:h <c-r><c-w><cr>
" }}}

" Workspaces {{{
command -nargs=? -complete=custom,workspaces#completion Workspaces call workspaces#run(<f-args>)
nnoremap <leader>ww :Workspaces write<cr>
" }}}

" Plugin mappings {{{
inoremap <silent><expr> <tab>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<tab>" :
      \ coc#refresh()
inoremap <silent><expr> <s-tab> coc#pum#visible() ? coc#pum#prev(1) : "\<c-h>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
      \ : "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"
noremap ? :normal \c<space><cr>
nnoremap <leader>i :source %<cr>:PlugInstall<cr>
nnoremap <leader>d :source %<cr>:PlugClean<cr>
nnoremap <leader>u :PlugUpdate \| PlugUpgrade<cr>
nnoremap <leader>r :GitGutterUndoHunk<cr>
nnoremap <leader>g :Magit<cr>
nnoremap <leader>\ :TagbarToggle<cr>
nnoremap <leader>/ :Rg <c-r><c-w><cr>
nnoremap <leader>b :GitBlame
nnoremap <silent> <leader>p :GitGutterPreviewHunk<cr>
nnoremap <silent> <leader>n :NERDTreeToggle<cr>
nnoremap <silent> gd <plug>(coc-definition)
nnoremap <silent> gi <plug>(coc-implementation)
nnoremap <silent> gr <plug>(coc-references)
nnoremap <silent> K :call CocActionAsync('doHover')<cr>
nnoremap <silent> g/ :Rg <c-r><c-w><cr>
nnoremap <silent> C :CocConfig<cr>
nnoremap <silent> P :call RunFZF()<cr>
nnoremap <silent> O :Buffers<cr>
vnoremap <up> <Plug>(expand_region_expand)
vnoremap <down> <Plug>(expand_region_shrink)
command -nargs=1 NewFile execute 'e %:h/'.<f-args>
" }}}

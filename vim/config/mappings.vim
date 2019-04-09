"
" Author:      Chris Kim
" Description: Custom key mappings
"

" Useful and Random mappings {{{
map ; :
noremap <cr> G
nnoremap <silent> Q :q<cr>
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
nnoremap <silent> L :noh<cr>
nnoremap + <c-a>
nnoremap - <c-x>
nnoremap v <c-v>
nnoremap V v
nnoremap <c-v> V
nnoremap <silent> Y ""dd
nnoremap d "_d
nnoremap x "_x
vnoremap c "_c
vnoremap d "_d
vnoremap x "*x
vnoremap y ygv
vnoremap Y "*ygv
vnoremap <c-c> "*ygv
vnoremap p P
vnoremap L g<c-g>
vnoremap / y/<c-r>"<cr>
vnoremap < <gv
vnoremap > >gv
" }}}

" Tab and split mappings {{{
nnoremap <tab> gt
nnoremap <s-tab> gT
nnoremap <silent> <expr> <m-[> (tabpagenr() == 1) ? ":tabm\<cr>" : ":-tabm\<cr>"
nnoremap <silent> <expr> <m-]> (tabpagenr() == tabpagenr('$')) ? ":0tabm\<cr>" : ":+tabm\<cr>"
nnoremap <leader>] <c-w>w
nnoremap <leader>[ <c-w>W
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" }}}

" Tag mappings {{{
nnoremap <leader><cr> :tab tag <c-r><c-w><cr>
nnoremap <c-]> :tab tag <c-r><c-w><cr>
vnoremap <c-]> <esc>:tab tag <c-r><c-w><cr>
" }}}

" Command line and some insert mappings {{{
inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$
inoremap <c-b> <c-o>b
inoremap <c-f> <c-o>w
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <m-bs> <c-w>
cnoremap ~~ <c-r>"
" }}}

" Plugin mappings {{{
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
noremap <silent> <m-/> :Commentary<cr>
nnoremap <leader>i :PlugInstall<cr>
nnoremap <leader>d :PlugClean<cr>
nnoremap <leader>u :PlugUpdate<cr>
nnoremap <leader>r :GitGutterUndoHunk<cr>
nnoremap <leader>b :TagbarToggle<cr>
nnoremap <leader>/ :Rg <c-r><c-w><cr>
nnoremap <silent> <leader>p :GitGutterPreviewHunk<cr>
nnoremap <silent> <leader>\ :NERDTreeToggle<cr>
nnoremap <silent> P :FZF<cr>
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


"
" Author:      Chris Kim
" Description: Custom key mappings
"

" Useful and Random mappings {{{
map ; :
noremap <cr> G
nnoremap <silent> <expr> Q (len(getbufinfo({'buflisted':1})) == 1) ? ":q\<cr>" : ":bp\|bd #\<cr>"
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

" Buffer, tab, split mappings {{{
nnoremap <tab> :bn<cr>
nnoremap <s-tab> :bp<cr>
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

" Plugin mappings {{{
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
noremap ? :normal \ci<cr>
nnoremap <leader>i :source %<cr>:PlugInstall<cr>
nnoremap <leader>d :source %<cr>:PlugClean<cr>
nnoremap <leader>u :PlugUpdate \| PlugUpgrade \| CocUpdate<cr>
nnoremap <leader>r :GitGutterUndoHunk<cr>
nnoremap <leader>b :TagbarToggle<cr>
nnoremap <leader>/ :Rg <c-r><c-w><cr>
nnoremap <silent> <leader>p :GitGutterPreviewHunk<cr>
nnoremap <silent> <leader>\ :NERDTreeToggle<cr>
nnoremap <silent> gd <plug>(coc-definition)
nnoremap <silent> gi <plug>(coc-implementation)
nnoremap <silent> gr :call CocAction('jumpReferences')<cr>
nnoremap <silent> C :CocConfig<cr>
nnoremap <silent> P :Files<cr>
nnoremap <silent> O :Buffers<cr>
nnoremap <silent> K :call CocActionAsync('doHover')<cr>
" }}}

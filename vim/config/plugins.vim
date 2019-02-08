"
" Author:      Chris Kim
" Description: Settings for installed plugins
"

" Airline " {{{
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch', 'hunks', 'ale']
let g:airline_section_z = '%l/%L : %c'
" }}}

" Auto-Pairs " {{{
au FileType html,vim let g:AutoPairs['<'] = '>'
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger = '<c-space>'
" }}}

" FZF " {{{
let g:fzf_action = { 'enter': 'tab split' }
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors = { 'fg': ['fg', 'Comment'] }
au FileType fzf set laststatus=0 cmdheight=1 noshowmode noruler
      \| au BufLeave <buffer> set laststatus=2 cmdheight=2 showmode ruler
" }}}

" NERDTree " {{{
let g:NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1
" }}}

" Ale " {{{
let g:ale_sign_column_always = 1
let g:ale_linters = { 'javascript': ['eslint'] }
" }}}

" Indent Guides " {{{
let g:indent_guides_color_change_percent = 15
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_soft_pattern = ' '
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0
" }}}

" vim-go {{{
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" }}}

" gitgutter {{{
let g:gitgutter_terminal_report_focus = 0
" }}}


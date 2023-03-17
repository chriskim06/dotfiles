"
" Author:      Chris Kim
" Description: Settings for installed plugins
"

" Airline {{{
let g:airline_theme = 'tomorrow'
let g:airline_exclude_filetypes = ['help', 'fzf']
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['branch', 'hunks', 'coc']
let g:airline_section_z = '%l/%L : %c'
let g:airline_skip_empty_sections = 1
" }}}

" coc-nvim {{{
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-yaml', 'coc-tsserver', 'coc-sh', 'coc-markdownlint', 'coc-pairs']
" }}}

" Tagbar {{{
let g:tagbar_width = max([25, winwidth(0) / 4])
let g:tagbar_autofocus = 1
let g:tagbar_case_insensitive = 1
let g:tagbar_show_visibility = 0
let g:tagbar_show_tag_linenumbers = 1
" }}}

" FZF {{{
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_colors = { 'fg': ['fg', 'Comment'] }
let g:fzf_buffers_jump = 1
au FileType fzf set laststatus=0 cmdheight=1 noshowmode noruler
      \| au BufLeave <buffer> set laststatus=2 cmdheight=2 showmode ruler
" }}}

" NERDCommenter {{{
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDToggleCheckAllLines = 0
let g:NERDTrimTrailingWhitespace = 1
let g:NERDDefaultAlign = 'start'
" }}}

" NERDTree {{{
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
" }}}

" Indent Guides {{{
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_soft_pattern = ' '
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0
let g:indent_guides_auto_colors = 0
" }}}

" go settings {{{
let g:go_def_mode = 'gopls'
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_experimental = 1
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
let g:go_version_warning = 0
" }}}

" gitgutter {{{
let g:gitgutter_terminal_report_focus = 0
" }}}

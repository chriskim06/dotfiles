"
" Author:      Chris Kim
" Description: Color settings
"

" these are for enabling italics
" set t_ZH=[3m
" set t_ZR=[23m
set termguicolors
let g:miramare_enable_italic = 1
let g:miramare_enable_italic_string = 1
colorscheme miramare
augroup ColorOverrides
  au!
  au FileType * hi IndentGuidesOdd guifg=#434343 guibg=#2A2426
  au FileType * hi IndentGuidesEven guifg=#434343 guibg=#363031
  au FileType * hi CocMenuSel guibg=#444444
  au FileType json hi jsonQuote guifg=#737373
augroup END

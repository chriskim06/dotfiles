"
" Author:      Chris Kim
" Description: Color settings
"

colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
set background=dark
augroup Colors
  au!
  au ColorScheme * hi CursorLine ctermbg=235
  au ColorScheme * hi TabLineFill ctermbg=236
  au ColorScheme * hi TabLineSel ctermfg=0 ctermbg=245
  au ColorScheme * hi Search ctermfg=1
augroup END


"
" Author:      Chris Kim
" Description: Color settings
"

let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox
augroup Colors
  au!
  au ColorScheme * hi CursorLine ctermbg=235
  au ColorScheme * hi TabLineFill ctermbg=236
  au ColorScheme * hi TabLineSel ctermfg=0 ctermbg=245
  au ColorScheme * hi Search ctermfg=1
augroup END

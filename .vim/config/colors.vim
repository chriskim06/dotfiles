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
let g:miramare_palette = {
      \ 'bg0':        ['#2A2426',   '235',  'Black'],
      \ 'bg1':        ['#242032',   '236',  'DarkGrey'],
      \ 'bg2':        ['#363031',   '237',  'DarkGrey'],
      \ 'bg3':        ['#242021',   '238',  'DarkGrey'],
      \ 'bg4':        ['#242021',   '239',  'Grey'],
      \ 'bg_red':     ['#392f32',   '52',   'DarkRed'],
      \ 'bg_green':   ['#333b2f',   '22',   'DarkGreen'],
      \ 'bg_blue':    ['#203a41',   '17',   'DarkBlue'],
      \ 'fg':         ['#e6d6ac',   '223',  'White'],
      \ 'red':        ['#e78365',   '167',  'Red'],
      \ 'orange':     ['#ffbb99',   '208',  'Red'],
      \ 'yellow':     ['#d0ab62',   '214',  'Yellow'],
      \ 'green':      ['#87af87',   '108',  'Green'],
      \ 'cyan':       ['#87c095',   '108',  'Cyan'],
      \ 'blue':       ['#89beba',   '109',  'Blue'],
      \ 'purple':     ['#d3a0bc',   '175',  'Magenta'],
      \ 'grey':       ['#444444',   '245',  'LightGrey'],
      \ 'light_grey': ['#737373',   '245',  'LightGrey'],
      \ 'gold':       ['#d8caac',   '214',  'Yellow'],
      \ 'none':       ['NONE',      'NONE', 'NONE']
      \ }
colorscheme miramare
augroup ColorOverrides
  au!
  au FileType * hi IndentGuidesOdd guifg=#434343 guibg=#2A2426
  au FileType * hi IndentGuidesEven guifg=#434343 guibg=#363031
  au FileType * hi CocMenuSel guibg=#444444
augroup END

"
" Author:      Chris Kim
" Description: General options and settings
"

syntax on " Turn on syntax highlighting
set encoding=utf-8 " Use utf-8 character encoding
set textwidth=0 " This should prevent vim from wrapping long lines of text
set wrapmargin=0 " This should prevent vim from wrapping long lines of text
set hidden " Hides buffer instead of closing; allows new tabs without saving
set wildmenu " Better command-line completion
set hlsearch " Highlight searches
set ignorecase " Use case insensitive search, except when using capital letters
set smartcase " Uses case sensitive search if the search has capital letters
set backspace=indent,eol,start " Makes backspace behave normally
set autoindent " Keep same indent as current line if no filetype-specific indenting
set nostartofline " Stop certain movements from always going to the first character of a line
set laststatus=2 " Always display the status line, even if only one window is displayed
set confirm " Requires confirmation for some actions
set vb t_vb= " Prevent vim from beeping or using visual bell
set cmdheight=2 " Set the command window height to 2 lines
set number " Display line numbers on the left
set notimeout ttimeout ttimeoutlen=50 " Quickly time out on keycodes, not on mappings
set expandtab " Inserts spaces when tab is pressed
set completeopt-=preview " Do not display scratch/preview window
set completeopt+=noselect " Force a selection from the menu
set scrolloff=3 " Keep at least 3 lines above/below cursor when possible
set mouse=a " Enable use of the mouse in all modes
set mousem=popup " Disable extending selection with right click
set foldmethod=syntax " Use syntax for folding
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " Exclude these files and directories
set formatoptions-=cro " Remove comment related formatting options
set shiftwidth=2 " Number of spaces to use when indenting lines
set tabstop=2 " Number of spaces a tab counts for in a file
set softtabstop=2 " Number of spaces for tabs when editing a file
set conceallevel=0 " Show text normally
set list " Show whitespace by default
set listchars=tab:»· " Set whitespace tab character
set matchpairs+=<:> " Add angle brackets to matchpairs
set viewoptions-=options " Don't store current working directory in mkview/loadview
set updatetime=250 " Shorten update delay
set winminheight=0 " Allow collapsing windows
set helpheight=1000 " Set help window to max height
set switchbuf=usetab,newtab " Options for determining how to switch buffers
set splitbelow " Put new split windows below
set cursorline " Highlight the current line
set signcolumn=yes " Always show signcolumn
let &t_SI = "\<Esc>[6 q" " Insert mode solid vertical line cursor
let &t_SR = "\<Esc>[4 q" " Replace mode solid underscore cursor
let &t_EI = "\<Esc>[2 q" " Normal mode solid block cursor

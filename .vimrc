packloadall
set shortmess+=I 	" Disable default startup message 
set noerrorbells visualbell t_vb=
set noshowmode 		" Disable mode message at bottom

" ------------------------------------------------------
" APPEARANCE SETTINGS 
" ------------------------------------------------------
set termguicolors

" ADAPT TO SYSTEM-WIDE APPEARANCE
function! SetBackgroundMode(...)
    call system("defaults read -g AppleInterfaceStyle")
    if v:shell_error==? 0
    	let s:new_bg = "dark"
    else
    	let s:new_bg = "light"
    endif
    if &background !=? s:new_bg
        let &background = s:new_bg
    endif
endfunction
call SetBackgroundMode()
call timer_start(3000, "SetBackgroundMode", {"repeat": -1})

" TRANSPARENT BACKGROUND
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None

set cursorline		" Highlight current line 

" ------------------------------------------------------
" EDITOR SETTINGS 
" ------------------------------------------------------
syntax on 
set clipboard=unnamed	" Use system clipboard
set showmatch 		" Highlight matching brackets
set number
set relativenumber
set autoindent
set splitright		" Sane splits
set splitbelow
set linebreak		" Wrap  
set undofile 		" Maintain Undo history
set undodir=~/.vim/undodir

" SEARCH
set ignorecase		
set smartcase
set incsearch 

" KEYBINDS 
let mapleader = ","
set showcmd
set mouse=c 		" Disable mouse
set backspace=indent,eol,start 
" Avoid using arrow keys
nnoremap <Left>  <Nop>
nnoremap <Right> <Nop>
nnoremap <Up>    <Nop>
nnoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Move by visual lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" CURSOR 
let &t_SI.="\e[3 q" "SI = INSERT mode
let &t_SR.="\e[2 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical barset nu

" ------------------------------------------------------
" LANGUAGE SPECIFIC CONFIGURATIONS
" ------------------------------------------------------

" ------------------------------------------------------
" PLUGIN SETTINGS 
" ------------------------------------------------------

" CTRL-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" AIRLINE
set ttimeoutlen =1 	" Delay when exiting insert mode
let g:airline_inactive_collapse=1
let g:airline#extensions#nerdtree_statusline = 1
let g:airline_powerline_fonts = 1
  " powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty=' !'
let g:airline_symbols.maxlinenr = ' '

" NERDTREE
map <C-n> :NERDTreeToggle<CR>
" Start if no file was specified at startup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
" Exit if last buffer remaining is NERDTree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set nocompatible
set shortmess+=I 	" Disable default startup message 
set noerrorbells visualbell t_vb=

" Clear terminal on exit 
autocmd VimLeave * :!clear	

" ----------------------------------------------------------------------------
" APPEARANCE SETTINGS 
" ----------------------------------------------------------------------------

set fillchars=vert:\│	" Because \| doesnt fill line
set noshowmode 		" Disable mode display at bottom
colorscheme iceberg

" CURSORLINE------------------------------------------------------------------
autocmd VimEnter,WinEnter,BufWinEnter 	* setlocal cursorline 
autocmd WinLeave 			* setlocal nocursorline

" COLOR ADJUSTMENTS-----------------------------------------------------------
function Adjustcolors()
	hi Normal ctermbg	= NONE
	hi Nontext ctermbg	= NONE
	hi LineNr ctermbg 	= NONE
	hi EndOfBuffer ctermbg 	= NONE
	if &background == 'dark'
		hi CursorLine ctermbg 	= 233
		hi CursorLineNr ctermbg = 233
	else 
		hi CursorLine ctermbg 	= 253
		hi CursorLineNr	ctermbg = 253
	endif
endfunction

autocmd ColorScheme * call Adjustcolors()

" BACKGROUND TRANSITION-------------------------------------------------------
" At startup
call system("defaults read -g AppleInterfaceStyle")
if v:shell_error == 0
	set background=dark
else 
	set background=light
endif

" Manual change
function Setbackground()
	if &background == 'dark'
		set background=light
	else
		set background=dark
	endif
endfunction

" Convenient Keybind
nnoremap <leader>tt :call Setbackground()<CR>

" CURSOR----------------------------------------------------------------------
let &t_SI.="\e[3 q" "SI = INSERT mode
let &t_SR.="\e[2 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" ----------------------------------------------------------------------------
" EDITOR SETTINGS 
" ----------------------------------------------------------------------------

syntax on 
filetype plugin indent on
set clipboard=unnamed	" Use system clipboard
set showmatch 		" Highlight matching brackets
set number
set relativenumber
set autoindent
set splitright		" Sane splits
set splitbelow
set linebreak		" Wrap  

" SEARCH----------------------------------------------------------------------
set ignorecase		
set smartcase
set incsearch 

" KEYBINDS--------------------------------------------------------------------
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

" ----------------------------------------------------------------------------
" LANGUAGE SPECIFIC CONFIGURATIONS
" ----------------------------------------------------------------------------

" LaTeX-----------------------------------------------------------------------
let g:tex_flavor = "latex"

" ----------------------------------------------------------------------------
" PLUGIN SETTINGS 
" ----------------------------------------------------------------------------

packloadall

" BATTERY.VIM ----------------------------------------------------------------
let g:battery#update_interval = 10000
let g:battery#component_format = '%v%%%s'

" AIRLINE---------------------------------------------------------------------
set ttimeoutlen =1 	" Delay when exiting insert mode
let g:airline_inactive_collapse=1

" Powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty=' !'
let g:airline_symbols.maxlinenr = ' '

"Shorten filepath
function Shortpath()
	if expand('%:p:h')=='/'
		return '/'.expand('%:t')
	elseif expand('%p:h:h')=='/'
		return '/'.expand('%:p:h:t').'/'.expand('%:t')
	else
		return '../'.expand('%:p:h:h:t').'/'.expand('%:p:h:t').'/'.expand('%:t')
	endif
endfunction

"Airline sections 
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline_section_y = '%{battery#component()}'
let g:airline_section_c = '%{Shortpath()}'

" NERDTREE--------------------------------------------------------------------
 map <C-n> :NERDTreeToggle<CR>

" Exit if last buffer remaining is NERDTree 
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

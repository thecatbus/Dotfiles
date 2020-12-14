set nocompatible
set shortmess+=I 	" Disable default startup message 
set noerrorbells visualbell t_vb=

" Clear terminal on exit 
autocmd VimLeave * :!clear	

" ----------------------------------------------------------------------------
" APPEARANCE SETTINGS 
" ----------------------------------------------------------------------------

set cursorline		" Highlight current line 
set fillchars=vert:\│	" Because \| doesnt fill line
set noshowmode 		" Disable mode display at bottom
colorscheme iceberg

" TRANSPARENT BACKGROUND------------------------------------------------------
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None

" BACKGROUND TRANSITION-------------------------------------------------------
" At startup
call system("defaults read -g AppleInterfaceStyle")
if v:shell_error == 0
	set background=dark
else 
	set background=light
endif

" Otherwise
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

"Airline sections 
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline_section_y = '%{battery#component()}'

" NERDTREE--------------------------------------------------------------------
 map <C-n> :NERDTreeToggle<CR>

" Start if no file was specified at startup
 autocmd StdinReadPre * let s:std_in=1
 autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" Exit if last buffer remaining is NERDTree 
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

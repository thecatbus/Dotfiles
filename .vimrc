set nocompatible
set shortmess+=I 	" Disable default startup message 
set noerrorbells visualbell t_vb=

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
	hi SignColumn ctermbg 	= NONE
    hi link markdownItalic Normal
    hi link markdownError Normal
	if &background == 'dark'
		hi CursorLine ctermbg 	= 235
		hi CursorLineNr ctermbg = 235
	else 
		hi CursorLine ctermbg 	= 253
		hi CursorLineNr	ctermbg = 253
	endif
endfunction

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

autocmd ColorScheme * call Adjustcolors()

" BACKGROUND TRANSITION-------------------------------------------------------
" At startup
function Startupbackground()
	call system("defaults read -g AppleInterfaceStyle")
	if v:shell_error == 1
		set background=light
	else 
		set background=dark
	endif
endfunction

call Startupbackground()

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

set tabstop=4
set shiftwidth=4
set expandtab

set noswapfile

" SEARCH----------------------------------------------------------------------
set ignorecase		
set smartcase
set incsearch 

" KEYBINDS--------------------------------------------------------------------
set showcmd
set mouse=c 		" Disable mouse
set backspace=indent,eol,start 

" Easier completion
inoremap <C-j>	<C-n>
inoremap <C-k>  <C-p>

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

" Haskell --------------------------------------------------------------------
autocmd filetype haskell autocmd BufWritePre <buffer> call CocAction('format')
let g:haskell_indent_disable = 1

" LaTeX ----------------------------------------------------------------------
let g:tex_flavor = "latex"
let g:vimtex_view_method = "skim"
let g:vimtex_viewer_general = "skim"
let g:vimtex_view_automatic = 1
let g:vimtex_fold_enabled = 0

" Automatically cut lines
function SetWidth()
	if &filetype == 'tex' 
		set tw=80
	endif 
endfunction

autocmd VimEnter,WinEnter,BufWinEnter 	* call SetWidth()

" ----------------------------------------------------------------------------
" PLUGIN SETTINGS 
" ----------------------------------------------------------------------------

packloadall

" COC ------------------------------------------------------------------------
" set hidden 		" recommended
" set nobackup		" some servers might have issues with backup files
" set nowritebackup
" set cmdheight=2	" more space for message display
set updatetime=300
" set signcolumn=yes	" Always show alert-sign (>>) column

" Remap keys for gotos
nmap <leader>dd <Plug>(coc-definition)
nmap <leader>dt <Plug>(coc-type-definition)
nmap <leader>di <Plug>(coc-implementation)
nmap <leader>dr <Plug>(coc-references)

" Apply quickfix (linter) suggestion
nmap <leader>qf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" BATTERY.VIM ----------------------------------------------------------------
let g:battery#update_interval = 10000
let g:battery#component_format = '%v%%%s'

" AIRLINE --------------------------------------------------------------------
set ttimeoutlen =1 	" Delay when exiting insert mode
let g:airline_inactive_collapse=1

" Powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty=' !'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ' ㏇:'

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
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

" Airline Extensions
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#nerdtree_statusline = 0

" NERDTREE--------------------------------------------------------------------
 map <silent> <C-n> :NERDTreeToggle<CR>

" Exit if last buffer remaining is NERDTree 
 autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set nocompatible
set shortmess+=I 	" Disable default startup message 
set noerrorbells visualbell t_vb=

" Make sure you start a server
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('parth@vim')
endif

" ----------------------------------------------------------------------------
" APPEARANCE SETTINGS 
" ----------------------------------------------------------------------------

set fillchars=eob:\ ,vert:\│ 
set noshowmode 		" Disable mode display at bottom
set conceallevel=2
set signcolumn=yes

" GUI APPEARANCE -------------------------------------------------------------

set guifont=APL386\ Nerd\ Font:h18
set guioptions= 
set transparency=15
set blur=40

function Winpreset_large()
    winpos 20 20 
    set lines=50 columns=148
endfunction

function Winpreset_medium()
    winpos 350 250
    set lines=28 columns=87
endfunction

function Winpreset_latex()
    if &filetype == 'tex' 
        winpos 20 20 
        set lines=50 columns=87
    endif
endfunction

nnoremap <leader>wl :call Winpreset_large()<CR>
nnoremap <leader>wm :call Winpreset_medium()<CR>
autocmd VimEnter,WinEnter,BufWinEnter 	* call Winpreset_latex()


" CURSORLINE------------------------------------------------------------------
"autocmd VimEnter,WinEnter,BufWinEnter 	* setlocal cursorline 
"autocmd WinLeave 			* setlocal nocursorline

" COLOR AND HIGHLIGHT ADJUSTMENTS---------------------------------------------

function Adjustcolors()
    " Diff colours in signcolumn
    hi DiffAdd guibg=bg guifg=#A6E3A1
    hi DiffChange guibg=bg guifg=#89B4FA
    hi DiffDelete guibg=bg guifg=#FAB387
    hi link markdownItalic Normal
    hi link markdownError Normal
    hi markdownBold gui=bold
    hi markdownItalic gui=italic
endfunction

nmap <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

autocmd ColorScheme * call Adjustcolors()

function MathHighlights()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    syn region math start=/\\begin{.*}/ end=/\\end{.*}/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$]\(.\|\n\)\{-}\$'

    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathHighlights()

" BACKGROUND TRANSITION-------------------------------------------------------
" At startup
function Startupbackground()
	call system("defaults read -g AppleInterfaceStyle")
	if v:shell_error == 1
        colorscheme catppuccin_latte
	else 
        colorscheme catppuccin_mocha
	endif
endfunction

call Startupbackground()

" Manual change
function Setbackground()
	if &background == 'dark'
        colorscheme catppuccin_latte
	else
        colorscheme catppuccin_mocha
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

set scrolloff=10

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
nnoremap <left>  <Nop>
nnoremap <right> <Nop>
nnoremap <up>    <Nop>
nnoremap <down>  <Nop>
inoremap <left>  <Nop>
inoremap <right> <Nop>
inoremap <up>    <Nop>
inoremap <down>  <Nop>

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
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'sioyek'
let g:vimtex_view_automatic = 1
let g:vimtex_fold_enabled = 0

let g:vimtex_quickfix_ignore_filters = [
          \ 'has changed',
          \ 'Underfull', 
          \ 'Overfull',
          \ 'textexclamdown', 
          \ 'author', 
          \ 'starttoc',
          \ 'counter',
          \ 'Marginpar',
          \]

" Don't conceal in tex 
function SetConceal()
    if &filetype == 'tex'
        set conceallevel=0
    else 
        set conceallevel=2
    endif 
endfunction

autocmd VimEnter,WinEnter,BufWinEnter 	* call SetConceal()

" Automatically cut lines
function SetWidth()
	if index(['tex', 'markdown'], &filetype) >= 0
		set tw=80
    elseif &filetype == 'text' 
		set tw=50
	endif 
endfunction

autocmd VimEnter,WinEnter,BufWinEnter 	* call SetWidth()

" ----------------------------------------------------------------------------
" PLUGIN SETTINGS 
" ----------------------------------------------------------------------------

packloadall

" COC ------------------------------------------------------------------------
set hidden 		" recommended
" set nobackup		" some servers might have issues with backup files
" set nowritebackup
" set cmdheight=2	" more space for message display
set updatetime=300

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

" Airline Extensions
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1

" let g:airline#extensions#hunks#non_zero_only = 0

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
"let g:airline_section_error = ''
"let g:airline_section_warning = ''
"let g:airline_section_y = '%{battery#component()}'
"let g:airline_section_c = '%{Shortpath()}'
"let g:airline_mode_map = {
"      \ '__'     : '-',
"      \ 'c'      : 'C',
"      \ 'i'      : 'I',
"      \ 'ic'     : 'I',
"      \ 'ix'     : 'I',
"      \ 'n'      : 'N',
"      \ 'multi'  : 'M',
"      \ 'ni'     : 'N',
"      \ 'no'     : 'N',
"      \ 'R'      : 'R',
"      \ 'Rv'     : 'R',
"      \ 's'      : 'S',
"      \ 'S'      : 'S',
"      \ ''     : 'S',
"      \ 't'      : 'T',
"      \ 'v'      : 'V',
"      \ 'V'      : 'V',
"      \ ''     : 'V',
"      \ }


" FZF--------------------------------------------------------------------------
set rtp+=/usr/local/opt/fzf

let g:fzf_preview_window = []
let g:fzf_colors =
\ { 'fg':      ['fg', 'Comment'],
  \ 'bg':      [-1],
  \ 'hl':      ['fg', 'Label'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     [-1],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']}

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hf :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

" GOYO/Limelight -------------------------------------------------------------

function! s:goyo_enter()
  "Turn off noise
  set noshowcmd
  set scrolloff=999
  "Quit on :q"
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  "Turn on Limelight
  Limelight
endfunction

function! s:goyo_leave()
  "Turn on options
  set showcmd
  set scrolloff=10
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  "Turn off Limelight
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" ULTISNIPS ------------------------------------------------------------------
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories = ["ultisnips"]

set nocompatible
set shortmess+=I 	" Disable default startup message
set noerrorbells visualbell t_vb=

helptags ALL

" Make sure you start a server
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('parth@vim')
endif

" Set texbook folder
let g:texbook_root = $HOME.'/Notebook'

" ----------------------------------------------------------------------------
" APPEARANCE SETTINGS
" ----------------------------------------------------------------------------

set fillchars=fold:\ ,eob:\ ,vert:\│
set noshowmode 		" Disable mode display at bottom
set conceallevel=0
set signcolumn=yes

" GUI APPEARANCE -------------------------------------------------------------

set guifont=APL386\ Nerd\ Font:h15
set guioptions=a
set titlestring=‎
"set transparency=15
"set blur=40

" Default window size
" winpos 84 53
" set lines=49 columns=150

" function! Winpreset_preview()
"     winpos 20 20
"     set lines=53 columns=87
" endfunction
"
" nnoremap <leader>wp :call Winpreset_preview()<CR>

" LINE NUMBER-----------------------------------------------------------------
autocmd VimEnter,WinEnter,BufWinEnter 	* setlocal cursorline
autocmd VimEnter,WinEnter,BufWinEnter 	* setlocal relativenumber
autocmd WinLeave 			* setlocal nocursorline
autocmd WinLeave 			* setlocal norelativenumber

" COLOR AND HIGHLIGHT ADJUSTMENTS---------------------------------------------

function! Adjustcolors()
    hi cursorline guibg=NONE
    " Diff colours in signcolumn
    if &background == 'light'
        hi DiffAdd guibg=bg guifg=#a6d189
        hi DiffChange guibg=bg guifg=#04a5e5
        hi DiffDelete guibg=bg guifg=#e64553
        let g:terminal_ansi_colors = [
            \'#4c4f69', '#d20f39', '#40a02b', '#df8e1d', '#1e66f5', '#ea76cb', '#209fb5', '#ccd0da',
            \'#6c6f85', '#d20f39', '#40a02b', '#df8e1d', '#1e66f5', '#ea76cb', '#209fb5', '#eff1f5' ]
    else
        hi DiffAdd guibg=bg guifg=#a6e3a1
        hi DiffChange guibg=bg guifg=#8caaee
        hi DiffDelete guibg=bg guifg=#ea999c
        let g:terminal_ansi_colors = [
            \'#1e1e2e', '#f38ba8', '#a6e3a1', '#f9e2af', '#89b4fa', '#f5c2e7', '#94e2d5', '#cdd6f4',
            \'#6c7086', '#f38ba8', '#a6e3a1', '#f9e2af', '#89b4fa', '#f5c2e7', '#94e2d5', '#a6adc8' ]
    endif

    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      [0],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'Normal'],
      \ 'bg+':     [0],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

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

function! MathHighlights()
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
function! Setbackground()
    call system("defaults read -g AppleInterfaceStyle")
    if v:shell_error == 1
        set background=light
        colorscheme catppuccin_latte
    else
        set background=dark
        colorscheme catppuccin_mocha
    endif
endfunction

call Setbackground()

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

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * call TrimWhitespace()

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

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.DS_Store

" Haskell --------------------------------------------------------------------
autocmd filetype haskell autocmd BufWritePre <buffer> call CocAction('format')
let g:haskell_indent_disable = 1

" LaTeX ----------------------------------------------------------------------
let g:tex_flavor = "latex"

let g:vimtex_view_method = 'skim'
let g:vimtex_view_skim_sync = 1
let g:vimtex_view_automatic = 1
let g:vimtex_fold_enabled = 0
let g:vimtex_view_reverse_search_edit_cmd = 'split'
" let g:vimtex_view_general_options = '@pdf --qwindowgeometry 745x1002+915+20 --execute-command toggle_titlebar'

let g:vimtex_toc_todo_labels = {'TODO': 'TODO: ', 'ADDREFERENCE': 'CITE: ', 'CHECKTHIS': 'CHECK: ', 'FIXTHIS': 'FIX: ', 'EXPAND': 'EXPAND: ', 'REMOVETHIS': 'REMOVE: ', 'UNKNOWN': 'UNKNOWN: '}

let  g:vimtex_fold_types = {
           \ 'envs' : {'enabled' : 0 }
           \}


let g:vimtex_quickfix_ignore_filters = [
          \ 'has changed',
          \ 'Underfull',
          \ 'Overfull',
          \ 'textexclamdown',
          \ 'author',
          \ 'starttoc',
          \ 'counter',
          \ 'Marginpar',
          \ 'PDF string',
          \]

" Quickly open base directory
nnoremap <leader>od :execute "!open " . expand("%:h")<CR>

" Don't conceal in tex
" function! SetConceal()
"     if &filetype == 'tex'
"         set conceallevel=0
"     else
"         set conceallevel=2
"     endif
" endfunction

" autocmd VimEnter,WinEnter,BufWinEnter 	* call SetConceal()

" Automatically cut lines
function! SetWidth()
    if index(['tex', 'markdown'], &filetype) >= 0
        set tw=80
    elseif &filetype == 'text'
        set tw=50
    endif
endfunction

autocmd VimEnter,WinEnter,BufWinEnter 	* call SetWidth()

" GAP ------------------------------------------------------------------------

augroup gap
  " Remove all gap autocommands
  au!
autocmd BufRead,BufNewFile *.g,*.gi,*.gd set filetype=gap comments=s:##\ \ ,m:##\ \ ,e:##\ \ b:#
augroup END

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

" COC EXPLORER ---------------------------------------------------------------

nmap <leader>e :CocCommand explorer<CR>

" COC SNIPPETS ---------------------------------------------------------------

" imap <C-l> <Plug>(coc-snippets-expand)
" vmap <C-j> <Plug>(coc-snippets-select)
imap <S-Space> <Plug>(coc-snippets-expand-jump)
" xmap <leader>x  <Plug>(coc-convert-snippet) " Create new snippet with current selected text, visual mode only.

" GIT ------------------------------------------------------------------------
nmap gj <Plug>(coc-git-nextchunk)
nmap gk <Plug>(coc-git-prevchunk)
nmap cj <Plug>(coc-git-nextconflict)
nmap ck <Plug>(coc-git-prevconflict)
nmap gd <Plug>(coc-git-chunkinfo)
nmap gc <Plug>(coc-git-commit)
nmap gs :CocCommand git.chunkStage<CR>
nmap gsu :CocCommand git.chunkUnstage<CR>

" CTRL P ---------------------------------------------------------------------

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_extensions = ['line', 'quickfix', 'texbook']
let g:ctrlp_show_hidden = 1


nnoremap <silent> <leader>tb :CtrlPTeXbook<CR>

" AIRLINE --------------------------------------------------------------------

set ttimeoutlen=1 	" Delay when exiting insert mode
let g:airline_inactive_collapse = 1
let g:airline_detect_modified = 0

" Symbols
let g:airline_powerline_fonts = 1

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='()'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.colnr = ', '
let g:airline_symbols.linenr = ''
let g:airline_symbols.crypt = ''
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : '',
      \ 'i'      : '󰴓',
      \ 'ic'     : '󰴓',
      \ 'ix'     : '󰴓',
      \ 'n'      : '󰇀',
      \ 'niI'    : '󰆿',
      \ 'niR'    : '󰆿',
      \ 'niV'    : '󰆿',
      \ 'multi'  : '󱢓',
      \ 'ni'     : '󰆿',
      \ 'no'     : '󰆿',
      \ 'R'      : '',
      \ 'Rv'     : '',
      \ 's'      : '󰗧',
      \ 'S'      : '󰗧',
      \ ''     : '󰗧',
      \ 't'      : '',
      \ 'v'      : 'ﳳ',
      \ 'V'      : '',
      \ ''     : '',
      \ }

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tex'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['bib'] = '󱨡'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['txt'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['markdown'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['m2'] = '󰡱'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['gap'] = '󰘨'

"Airline sections

function! Shortpath()
    let shortpath = expand('%:t')

    if expand('%:p:h')!='/'
        let shortpath = expand('%:p:h:t').'/'.shortpath
    endif
    if expand('%:p:h:h')!='/'
        let shortpath = '../'.shortpath
    endif

    let currentfunction = get(b:,'coc_current_function','')
    if currentfunction != ''
        let shortpath = shortpath.'/'.currentfunction
    endif

    return shortpath
endfunction

let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0
let g:airline_skip_empty_sections = 1
function! AirlineInit()
    let g:airline_section_b = airline#section#create_left(['(%2v,%l)'])
    let g:airline_section_c = airline#section#create_left(['%{Shortpath()}','readonly','coc_status','lsp_progress'])
    let g:airline_section_x = airline#section#create_right(['branch'])
    let g:airline_section_y = airline#section#create_right(['hunks'])

    let filetypes = get(g:, 'airline#extensions#wordcount#filetypes',
        \ ['asciidoc', 'help', 'mail', 'markdown', 'rmd', 'nroff', 'org', 'rst', 'plaintex', 'tex', 'text'])
    if index(filetypes, &filetype) <= -1
        let g:airline_section_z = airline#section#create_right([' %L'])
    else
        let g:airline_section_z = airline#section#create_right([])
    endif
    let g:airline#extensions#wordcount#formatter#default#fmt = ' %s'
    let g:airline#extensions#wordcount#formatter#default#fmt_short = ' %s'

    let g:airline_section_z = get(g:, 'airline_section_z', '')
    let g:airline_section_z .= ' | '.'%{WebDevIconsGetFileTypeSymbol()}'

endfunction
autocmd User AirlineAfterInit call AirlineInit()

" Airline-term
let g:airline#extensions#term#enabled = 0

"Airline-fzf
"let g:airline#extensions#fzf#enabled = 1

" Airline-git
let g:airline#extensions#hunks#coc_git = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#hunks#hunk_symbols = [' ', ' ', ' ']

" Airline-coc
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#show_coc_status = 1
let airline#extensions#coc#error_symbol = ' '
let airline#extensions#coc#stl_format_err = '%C[%L]'
let airline#extensions#coc#warning_symbol = ' '
let airline#extensions#coc#stl_format_warn = '%C[%L]'

" Airline-vimtex
let g:airline#extensions#vimtex#enabled=0
let g:airline#extensions#vimtex#wordcount=0
let g:airline#extensions#vimtex#left="{"
let g:airline#extensions#vimtex#right="}"

" Vimtex state indicators:

" the current tex file is the main project file (nothing is shown by default) >
let g:airline#extensions#vimtex#main = ""
" the current tex file is a subfile of the project and the compilation is set for the main file >
let g:airline#extensions#vimtex#sub_main = "m"
" the current tex file is a subfile of the project and the compilation is set for this subfile >
let g:airline#extensions#vimtex#sub_local = "l"
" single compilation is running >
let g:airline#extensions#vimtex#compiled = "c₁"
" continuous compilation is running >
let g:airline#extensions#vimtex#continuous = "c"
" viewer is opened >
let g:airline#extensions#vimtex#viewer = "v"

" FZF--------------------------------------------------------------------------
" set rtp+=/usr/local/opt/fzf
"
" let g:fzf_preview_window = []
" let g:fzf_layout = { 'down': '40%' }
"
" nnoremap <silent> <C-p> :Files<CR>
" nnoremap <silent> <Leader>/ :BLines<CR>
" nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
" nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
" nnoremap <silent> <Leader>hf :History<CR>
" nnoremap <silent> <Leader>h: :History:<CR>
" nnoremap <silent> <Leader>h/ :History/<CR>

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
" let g:UltiSnipsEditSplit = "context"
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsSnippetDirectories = ["ultisnips"]

" REPLY.VIM ------------------------------------------------------------------

function! s:define_gap_repl() abort
    return reply#repl#base('gap.sh', { 'prompt_start' : '^gap> ', 'prompt_continue' : '^> '})
endfunction

let g:reply_repls = {'gap' : [function('s:define_gap_repl')]}


nnoremap <silent> <S-CR> :ReplSend<CR>

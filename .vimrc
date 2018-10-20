"
" CN_VIM
"
" Description:
"     Configution for my Vim setup, inspired by UTK's vimrc setup, and modified
"     to suit me.
"
" Author:
"     Clara Nguyen

:syntax on

" -----------------------------------------------------------------------------
" Vim-airline stuff                                                        {{{1
" -----------------------------------------------------------------------------

execute pathogen#infect()

" Configure Airline
let g:airline_theme                      = 'stilz'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled  = 1
let g:airline_powerline_fonts            = 1

let g:airline#extensions#tabline#buffers_label = 'Files'
let g:airline#extensions#tabline#show_splits   = 0

let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Configure the strings of the status line
let g:airline_section_a       = ' VIM'
let g:airline_section_b       = airline#section#create(['mode'])
let g:airline_section_c       = airline#section#create(['%F'])
let g:airline_section_x       = airline#section#create(['[%{&fileformat}]'])
let g:airline_section_y       = airline#section#create(['filetype'])
let g:airline_section_z       = airline#section#create(
		\ [' %{fugitive#head()}'])
let g:airline_section_warning = airline#section#create(
		\ ['Col: %c | Line: %l / %L (%P) '])

" -----------------------------------------------------------------------------
" Configurations                                                           {{{1
" -----------------------------------------------------------------------------

" Vim folds and other configs
set foldmethod=marker
set t_kb=
set nocompatible
set backspace=eol,indent,start
set autoindent
set smartindent

filetype indent on

" don't highlight the last search upon startup
set viminfo="h"

" Do C-style auto indentation on C/C++/Perl files only :)
:filetype on
:autocmd FileType c,cpp,perl,html,php :set cindent
au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile *.cns set filetype=cn_script

" stop Vim from beeping all the time
set vb

" uncomment to insert spaces instead of a tab when tab is pressed
"set expandtab

" Configure tabbing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set tabpagemax=100

set ruler
"set background=dark

" Tell you if you are in insert mode
set showmode

" Match parenthesis, i.e. ) with (  and } with {
set showmatch

" Ignore case when doing searches
set ignorecase
set smartcase

" Tell you how many lines have been changed
set report=0

set scrolloff=5
set wildmode=longest,list
set incsearch
set hlsearch

set t_Co=8
colorscheme elflord

set showtabline=2

set number
set noshowmode

:set laststatus=2
set cursorline

set t_Co=256

" -----------------------------------------------------------------------------
" Highlighting Overrides                                                   {{{1
" -----------------------------------------------------------------------------

" Make the 81st column highlight
highlight ColorColumn ctermbg=red ctermfg=white
call matchadd('ColorColumn', '\%81v', 100)

" Make tabs show a \uBB character, followed by a hard space for the rest.
exec "set listchars=tab:\uBB\uA0,trail:\uB7,nbsp:~"
set list

" -----------------------------------------------------------------------------
" Hotkeys Overrides                                                        {{{1
" -----------------------------------------------------------------------------

" Switch buffers with F7 and F8.
" map <F7> :tabp<CR>
" map <F8> :tabn<CR>
map <F7> :bprev<CR>
map <F8> :bnext<CR>

" Open up file list with Ctrl+N
map <C-n> :NERDTreeToggle<CR>

" Open up the tagbar with Ctrl+B
nmap <C-b> :TagbarToggle<CR>

" -----------------------------------------------------------------------------
" Custom Status Line                                                       {{{1
" -----------------------------------------------------------------------------

" Get mode name from mode function
function! ModeName()
	let currentmode = mode()

	" Insert Mode
	if currentmode == 'i'
		hi User2 ctermbg=118
		hi User3 ctermbg=118 ctermfg=16
		hi User4 ctermfg=118
		return "INSERT"
	endif

	" Normal Mode
	if currentmode == 'n'
		hi User2 ctermbg=236
		hi User3 ctermbg=236 ctermfg=15
		hi User4 ctermfg=236
		return "NORMAL"
	endif

	" Replace Mode
	if currentmode == 'r'
		hi User2 ctermbg=196
		hi User3 ctermbg=196 ctermfg=15
		hi User4 ctermfg=196
		return "REPLACE"
	endif

	" Visual Mode
	if currentmode == 'v'
		hi User2 ctermbg=135
		hi User3 ctermbg=135 ctermfg=15
		hi User4 ctermfg=135
		return "VISUAL"
	endif

	" Visual Block Mode
	if currentmode == ""
		hi User2 ctermbg=135
		hi User3 ctermbg=135 ctermfg=15
		hi User4 ctermfg=135
		return 'VISUAL BLOCK'
	endif
endfunction

" Make Custom StatusLine
set statusline=%1*\ \ VIM\ %0*%2*%3*\ %{ModeName()}\ [%{mode()}]\ %4*%0*\ %F\ %=[%{&fileformat}]\ %8*%9*\ %{&filetype}\ %7*%6*\ Col:\ %c\ %5*%1*\ Line:\ %l\ /\ %L\ (%P)\ \ 

" -----------------------------------------------------------------------------
" Custom Colour Settings                                                   {{{1
" -----------------------------------------------------------------------------

" Force Colour Changes
augroup vimrc
	autocmd!
	autocmd ColorScheme *
		\ hi User1  ctermbg=238 ctermfg=15 cterm=bold |
		\ hi User2  ctermbg=236 ctermfg=238           |
		\ hi User3  ctermbg=236 ctermfg=15 cterm=bold |
		\ hi User4  ctermbg=233 ctermfg=236           |
		\ hi User5  ctermbg=236 ctermfg=238           |
		\ hi User6  ctermbg=236 ctermfg=15            |
		\ hi User7  ctermbg=6   ctermfg=236           |
		\ hi User8  ctermbg=233 ctermfg=6             |
		\ hi User9  ctermbg=6   ctermfg=15 cterm=bold |
	autocmd ColorScheme * hi LineNr cterm=bold
	"autocmd ColorScheme * hi LineNr ctermfg=DarkGrey
	autocmd ColorScheme * hi StatusLine cterm=NONE ctermbg=233 ctermfg=White
	autocmd ColorScheme * hi CursorLine cterm=NONE ctermbg=233
	autocmd ColorScheme * hi LineNr term=bold ctermbg=NONE ctermfg=15
	autocmd ColorScheme * hi TabLine term=none cterm=underline ctermfg=7 ctermbg=236 gui=underline guibg=DarkGray
	autocmd ColorScheme * hi TabLineSel term=bold cterm=bold ctermbg=8 gui=bold
	autocmd ColorScheme * hi TabLineFill term=none cterm=none ctermbg=7 gui=none
augroup END

syntax enable

highlight SpecialKey ctermfg=238

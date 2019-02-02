"
" CN_Experience (Vim dotfile)
"
" Description:
"     Configution for my Vim setup, inspired by UTK's vimrc setup, and modified
"     to suit me.
"
" Author:
"     Clara Nguyen (@iDestyKK)
"

" 0. External Include Files                                                {{{1
" -----------------------------------------------------------------------------

	" Highly specific stuff should be defined in other files. Generally I put
	" them in my ".vim" directory rather than cluttering up the home directory.
	
	source ~/.vim/cn_experience/plugins.vim " Configures Vim Airline


" 1. Configurations                                                        {{{1
" -----------------------------------------------------------------------------

	" The general configuration of Vim. Most options are commented. Enable or
	" disable whatever you want.


	" 1.1. CN_Experience Exclusive                                         {{{2
	" -------------------------------------------------------------------------
	
	let multi_file_mode="buffer"   " Enable buffer hotkeys over tab hotkeys


	" 1.2. General Configurations                                          {{{2
	" -------------------------------------------------------------------------

	set t_Co=256                   " 256 colour mode
	syntax on                      " Enable Syntax Highlighting
	colorscheme elflord            " This is a no-brainer
	set t_kb=                    " Configures backspace key
	set nocompatible
	set backspace=eol,indent,start " Let us backspace over line breaks
	set viminfo="h"                " Don't highlight the last search upon
	                               " startup
	set vb                         " Disable beeping
	set scrolloff=5                " See 5 lines above and below the current
	set foldmethod=marker          " Use {{{ and }}} for Vim folds
	set number                     " Show numbers on the left side


	" 1.3. Indentation                                                     {{{2
	" -------------------------------------------------------------------------
	
	set tabstop=4                  " 4 space tabs
	set shiftwidth=4
	set softtabstop=4
	set smarttab
	set tabpagemax=100

	set autoindent                 " Obvious
	set smartindent

	filetype indent on

	" Do C-style auto indentation on C/C++/Perl files only :)
	:filetype on
	:autocmd FileType c,cpp,perl,html,php :set cindent


	" 1.4. Syntax Highlighting                                             {{{2
	" -------------------------------------------------------------------------
	
	" Manual syntax highlighting
	au BufRead,BufNewFile *.coffee set filetype=coffee " CoffeeScript
	au BufRead,BufNewFile *.cns set filetype=cn_script " CN_Script


	" 1.5. Bottom Statusline                                               {{{2
	" -------------------------------------------------------------------------
	
	" These are overwritten anyways, but go on in case the custom statusline
	" fails.
	
	set ruler      " Enable ruler at bottom right
	set showmode   " Show the current mode
	set showmatch  " Show matching braces


	" 1.6. Searching                                                       {{{2
	" -------------------------------------------------------------------------
	
	set ignorecase " Ignore case when searching
	set smartcase  " If first char is uppercase, search is case sensitive

	set report=0   " Tell you how many lines have been changed

	set incsearch   " Incremental Search
	set hlsearch    " Highlight all found items

	set wildmode=longest,list


	" 1.7. Miscellaneous                                                   {{{2
	" -------------------------------------------------------------------------

	set showtabline=2
	set noshowmode
	set laststatus=2
	set cursorline

	" 2}}}


" 2. Highlighting Overrides                                                {{{1
" -----------------------------------------------------------------------------

	" Minor changes to how Vim represents text data.


	" 2.1. Make 81st column highlight                                      {{{2
	" -------------------------------------------------------------------------

	highlight ColorColumn ctermbg=red ctermfg=white
	call matchadd('ColorColumn', '\%81v', 100)


	" 2.2. Make tabs show a >>. Make extra spaces show a dot.              {{{2
	" -------------------------------------------------------------------------
	
	exec "set listchars=tab:\uBB\uA0,trail:\uB7,nbsp:~"
	set list

	" 2}}}


" 3. Hotkeys Overrides                                                     {{{1
" -----------------------------------------------------------------------------

	" Hotkeys and shortcuts which make life easier. You may configure which
	" you want to use by commenting out and vice versa.


	" 3.1. Tabs/Buffers                                                    {{{2
	" -------------------------------------------------------------------------
	
	" F7 and F8 depend on user settings
	if multi_file_mode == "tab"
		" Switch tabs with F7 and F8.
		map <F7> :tabp<CR>
		map <F8> :tabn<CR>
	elseif multi_file_mode == "buffer"
		" Switch buffers with F7 and F8.
		map <F7> :bprev<CR>
		map <F8> :bnext<CR>
	endif


	" 3.2. Plugin Hotkeys                                                  {{{2
	" -------------------------------------------------------------------------
		
	" Open up file list with Ctrl+N
	map <C-n> :NERDTreeToggle<CR>

	" Open up the tagbar with Ctrl+B
	nmap <C-b> :TagbarToggle<CR>

	" 2}}}


" 4. Custom Status Line                                                    {{{1
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

	" Make Custom StatusLine for if/when Vim Airline fails
	let sl_str =
		\ "%1*\ \ VIM\ %0*%2*%3*\ %{ModeName()}\ [%{mode()}]\ %4*%0" .
		\ "*\ %F\ %=[%{&fileformat}]\ %8*%9*\ %{&filetype}\ %7*%6*\ " .
		\ "Col:\ %c\ %5*%1*\ Line:\ %l\ /\ %L\ (%P)\ \ "
	set statusline=%!sl_str


" 5. Custom Colour Settings                                                {{{1
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
		autocmd ColorScheme * hi StatusLine cterm=NONE ctermbg=233 
			\ ctermfg=White
		autocmd ColorScheme * hi CursorLine cterm=NONE ctermbg=233
		autocmd ColorScheme * hi LineNr term=bold ctermbg=NONE ctermfg=15
		autocmd ColorScheme * hi TabLine term=none cterm=underline ctermfg=7
			\ ctermbg=236 gui=underline guibg=DarkGray
		autocmd ColorScheme * hi TabLineSel term=bold cterm=bold ctermbg=8 
			\ gui=bold
		autocmd ColorScheme * hi TabLineFill term=none cterm=none ctermbg=7 
			\ gui=none
	augroup END

	syntax enable

	highlight SpecialKey ctermfg=238

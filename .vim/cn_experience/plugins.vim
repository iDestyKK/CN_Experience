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

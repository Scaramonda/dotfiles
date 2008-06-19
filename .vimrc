" ~/.vimrc

let os_type=tolower(system('uname -s'))

" Abbreviations
ia #e andy@hexten.net
ia Therese Thérèse

"colorscheme kib_darktango
colorscheme golden
set autowrite       
set background=dark
set expandtab
"set hidden        
set hlsearch
"set ignorecase   
set incsearch     
"set mouse=a     
set shiftround
set shiftwidth=4
set showcmd     
set showmatch  
"set smartcase  
set softtabstop=4
set title
set t_vb=
set vb

set laststatus=2
set statusline=%-30(%f%m%r%h%w%)\ format:\ [%{&ff}]\ type:\ %y\ pos:\ [%4l,\ %3v,\ %3p%%]\ lines:\ [%L]\ buf:\ [%n]\ %a

set formatprg=perl\ -MText::Autoformat\ -e'autoformat'

syntax on
filetype plugin indent on

" Read template named after extension (not filetype)
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl

" Jump to line we were on
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

nmap ,tp :tabp<cr> 
nmap ,tn :tabn<cr> 

noremap <f3> <esc>:previous<cr>
noremap <f4> <esc>:next<cr>

noremap <f5> <esc>:bprevious<cr>
noremap <f6> <esc>:bnext<cr>

noremap <f7> <esc>:cprevious<cr>
noremap <f8> <esc>:cnext<cr>


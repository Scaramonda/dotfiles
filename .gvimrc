" Font setting appears to work differently on Mac OS. Probably need
" a case for Windows too.
if has('mac') 
    set guifont=Bitstream_Vera_Sans_Mono:h14
else
    set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
endif
colorscheme candycode
"colorscheme darkocean
"colorscheme golden
set guioptions=aegimrLt
set antialias
set vb
set t_vb=


" display the line number
"set nu

" smartindent
set smartindent
filetype plugin indent on

" syntax
syntax on

" activate pathogen.vim - manage 'runtimepath' with ease
"execute pathogen#infect()

" .cu file
au BufNewFile,BufRead *.cu set ft=cu

" cursor highlighting
:set cursorline

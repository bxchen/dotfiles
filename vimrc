""""""""""""""""""""""""""""""""""""""""""""
" pre-customization setup, including pathogen, leader key
""""""""""""""""""""""""""""""""""""""""""""

" explicitly setting nocompatiable mode, for Vim to use Vim defaults
set nocompatible

" activate pathogen.vim - manage 'runtimepath' with ease
" to include all plugins under the ~/.vim/bundle directory
" this is to let vim know where to find the pathogen.vim, other than the
" default ~/.vim/autoload directory
runtime bundle/vim-pathogen/autoload/pathogen.vim   

execute pathogen#infect()
call pathogen#helptags()

" change the mapleader from \ to ,
let mapleader=","

" quickly edit/reload the vimrc file
" ev - edit vim
" sv - source vim
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


""""""""""""""""""""""""""""""""""""""""""""
" 1. some basic Vim behaviour
""""""""""""""""""""""""""""""""""""""""""""

" have unwritten changes to a file and open a new file using :e, without being
" forced to write or undo your changes first
set hidden

" cursor highlighting
set cursorline      
:nnoremap <Leader>c :set cursorline! <CR>
":hi CursorLine   cterm=NONE ctermbg=darkblue ctermfg=white guibg=lightgray guifg=white
":hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white

" traverse line
set whichwrap=b,s,<,>,[,] 

" restore cursor position in files
if has("autocmd")   
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

"""""""""""""""""""""""""""""""
" example vimrc from ArchWiki
"""""""""""""""""""""""""""""""
" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1
    
syntax on           " syntax

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

"set smartindent     " automatically inserts one extrae level of indentation in 
                    " some cases, and works for C-like files. It might
                    " interfere with file type based indentation and should
                    " only be set manually if not satisfied with the file type
                    " based one

filetype plugin indent on " set file type based indent
                    " do NOT set "smartindent" or "cindent", if the file type
                    " based indent is on. "autoindent" may still be set  

set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
 
set copyindent      " copy the previous identation on autoindenting

set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
"set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
 
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    " to comments)
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.

set history=1000    " remember 1000 commands and search history
set undolevels=1000 " use 100 levels of undo
set wildignore=*.swp,*.bad,*.pyc,*.so   " ignore some file extensions when
                    " completing names by pressing Tab
set title           " change terminal's title

""""""""""""""""""""""""""""""""""""""""""""
" 2. set up some useful editing behaviour
""""""""""""""""""""""""""""""""""""""""""""

" make Vim set out tab characters, trailing whitespace and invisible spaces
" visually, and additionally use the # sign at the end of lines to mark lines
" that extend off-screen
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" toggle paste mode by pressing <F2>
set pastetoggle=<F2>

" Enable the use of the mouse for vim
"set mouse=a
" a simple Vim plugin: vim-togglemouse has been installed and <F12> is now the
" key to toggle the mouse between Vim and terminal.


""""""""""""""""""""""""""""""""""""""""""""
" 3. Get efficient - shortcut mapping
""""""""""""""""""""""""""""""""""""""""""""

" map : to ; for quick save
nnoremap ; :

" use Q for formatting the current paragrah or visual block
vmap Q gq
nmap Q gqap

" stop using arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" clears the search highlighting buffer
nmap <slient> ./ :nosearch<CR>

" use w!! to write to files that requires sudo privileges
cmap w!! w !sudo tee % >/dev/null


""""""""""""""""""""""""""""""""""""""""""""
" 4. tex related ... to be completed
""""""""""""""""""""""""""""""""""""""""""""

" for vim-latex suite
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
"set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'

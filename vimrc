
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:                                                                  "
"   01. General ................. General Vim behavior                       "
"   02. Events .................. General autocmd events                     "
"   03. Theme/Colors ............ Colors, fonts, etc.                        "
"   04. Vim UI .................. User interface behavior                    "
"   05. Text Formatting/Layout .. Text, tab, indentation related             "
"   06. Custom Commands ......... Any custom command aliases                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " get rid of Vi compatibility mode. SET FIRST!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. Vundle                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'nvie/vim-togglemouse'
Plugin 'JuliaLang/julia-vim'
Plugin 'YankRing.vim'
Plugin 'LustyJuggler'
Plugin 'gundo'
Plugin 'Valloric/YouCompleteMe'
Plugin 'visualrepeat'
Plugin 'HowMuch'
Plugin 'Tabular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Events                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on " filetype detection[ON] plugin[ON] indent[ON]

" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode.
set ofu=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Theme/Colors                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256              " enable 256-color mode.
syntax enable             " enable syntax highlighting (previously syntax on).
colorscheme default       " set colorscheme

" Prettify JSON files
autocmd BufRead,BufNewFile *.json set filetype=json
autocmd Syntax json sou ~/.vim/syntax/json.vim

" Prettify Vagrantfile
autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

" Prettify Markdown files
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Highlight characters that go over 80 columns (by drawing a border on the 81st)
if exists('+colorcolumn')
  set colorcolumn=81
  highlight ColorColumn ctermbg=red
else
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Vim UI                                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","
let maplocalleader="\\"

" set relativenumber        " show relative line numbers
" set numberwidth=6         " make the number gutter 6 characters wide
set cul                   " highlight current line

set autoread
set autowriteall

" search
set smartcase             " ignore case if all lower-case
set hlsearch              " highlight searched phrases.
set incsearch             " But do highlight as you type your search.
set ignorecase            " Make searches case-insensitive.
set showmatch

set pastetoggle=<F2>      " in insert mode toggle paste mode
set guioptions+=a
set mouse=r               " use the mouse 
set clipboard=unnamedplus,exclude:cons\|linux " normal clipboard interaction
set hidden                " hide buffers
set history=1000          " history
set undolevels=1000       " many undos
if v:version >= 703
    set undofile          " keep a persistent undo file
    set undodir=~/.vim/.undo,~/tmp,/tmp
    set undoreload=1000        
endif
set nobackup              " Really - have I ever use this?
set noswapfile            " Here also.
set wildmenu              " tab completion for files and dirs
set wildmode=list:full    " show a list when pressing tab
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set visualbell t_vb=      " don't beep or flash
set noerrorbells          " don't beep

nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>N :setlocal number!<cr>
vnoremap Q gq
nnoremap Q gqap

" grep for word under cursor
vnoremap <leader>a y:grep! "\b<c-r>"\b" <cr>:cs<cr>
nnoremap <leader>a :grep! "\b<c-r><c-w>\b" 
nnoremap K *N:grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

nnoremap ; :

nnoremap j gj
nnoremap k gk

" Restore cursor to last time opened
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" status lines
set laststatus=2          " last window always has a statusline
set showmode              " Always show what mode we are in
set showcmd               " show partial command in last line.
set ruler                 " Always show info along bottom.
if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
"    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" For when you forget to sudo.. Really write the file.
cmap w!! w !sudo tee % >/dev/null

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Text Formatting/Layout                                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent            " auto-indent
set smartindent           " automatically insert one extra level of indentation
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 2 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set smarttab              " use tabs at the start of a line, spaces elsewhere
set nowrap                " don't wrap text

set backspace=indent,eol,start " backspacing over everything
set copyindent            " copy previous indentation on autoindenting
set formatoptions+=1      " Don't allow 1-letter words at end of lines
set spell                 " spell checker

" Removes trailing spaces
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
" In case I want to use it...
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
" But like the automatic mode...
autocmd FileType python,java autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileType python,java autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FileType python,java autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd FileType python,java autocmd BufWritePre     * :call TrimWhiteSpace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Custom Commands                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo toggle
nnoremap <F5> :GundoToggle<CR>

" Prettify JSON files making them easier to read
command PrettyJSON %!python -m json.tool

" Python, but nice for other things to...
im :<CR> :<CR><TAB>

" Python - get rid of trailing white space
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

" HowMuch options
let g:HowMuch_scale = 10

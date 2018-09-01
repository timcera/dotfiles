
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:                                                                  "
"   General ................. General Vim behavior                           "
"   Events .................. General autocmd events                         "
"   Theme/Colors ............ Colors, fonts, etc.                            "
"   Vim UI .................. User interface behavior                        "
"   Text Formatting/Layout .. Text, tab, indentation related                 "
"   Search .................. Commands for searching                         "
"   Custom Commands ......... Any custom command aliases                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible         " get rid of Vi compatibility mode. SET FIRST!

if has('nvim')
    let s:editor_root=expand("~/.config/nvim")
else
    let s:editor_root=expand("~/.vim")
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to 
"                     update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to 
"                     refresh local cache
" :PluginClean      - confirms removal of unused plugins; 
"                     append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

filetype off                  " required

" set the runtime path to include Vundle and initialize
let vudir = s:editor_root . '/bundle/'
let &rtp .= ',' . vudir . 'Vundle.vim'

call vundle#begin( vudir )    " required
" Required to keep 'Plugin' commands between vundle#begin/end.

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
"
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

Plugin 'nvie/vim-togglemouse'
Plugin 'JuliaLang/julia-vim'
Plugin 'YankRing.vim'
Plugin 'gundo'
Plugin 'visualrepeat'
Plugin 'tpope/vim-repeat'
Plugin 'HowMuch'
Plugin 'Tabular'
Plugin 'tpope/vim-fugitive'
Plugin 'fountain.vim'
Plugin 'Konfekt/FastFold'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Rykka/riv.vim'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'Shougo/neocomplete'
Plugin 'reedes/vim-pencil'
Plugin 'rudrab/vimf90'
Plugin 'caglartoklu/fortran_line_length.vim'

" Required to keep 'Plugin' commands between vundle#begin/end.
call vundle#end()            " required

filetype plugin indent on    " required
                             " filetype detection[ON] plugin[ON] indent[ON]
" To ignore plugin indent changes, instead use:
"filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Events                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In Makefiles DO NOT use spaces instead of tabs
autocmd FileType make setlocal noexpandtab
" In Ruby files, use 2 spaces instead of 4 for tabs
autocmd FileType ruby setlocal sw=2 ts=2 sts=2

" Enable omnicompletion (to use, hold Ctrl+X then Ctrl+O while in Insert mode.
set ofu=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme/Colors                                                               "
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
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=mkd
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
" Vim UI                                                                     "
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
set swapfile              " I like the warning when using multiple sessions.

set wildmenu              " tab completion for files and dirs
set wildmode=list:full    " show a list when pressing tab
set wildignore=*.swp,*.bak,*.pyc,*.class,*.o
set visualbell t_vb=      " don't beep or flash
set noerrorbells          " don't beep

nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap <leader>N :setlocal number!<cr>
vnoremap Q gq
nnoremap Q gqap

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

    " Broken down into segments
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout                                                     "
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

set fileformat=unix

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
" Search                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <leader>ff to display all lines with keyword under cursor within current
" file and ask which one to jump to
nmap <leader>ff [I:let nr = input("Which one: ")<bar>exe "normal " . nr ."[\t"<cr>

" grep for word under cursor in files
vnoremap <leader>a y:grep! "\b<c-r>"\b" <cr>:cs<cr>
nnoremap <leader>a :grep! "\b<c-r><c-w>\b" 
nnoremap K *N:grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Commands                                                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo toggle
nnoremap <F5> :GundoToggle<CR>

" Prettify JSON files making them easier to read
command PrettyJSON %!python -m json.tool

" HowMuch options
let g:HowMuch_scale = 10

" Set fountain to soft wrap text
autocmd BufRead,BufNewFile *.fountain set filetype=fountain
autocmd Filetype fountain setlocal wrap linebreak nolist

let g:SimpylFold_docstring_preview = 1

" Python indentation
autocmd BufNewFile,BufRead *.py set textwidth=79 formatoptions+=ro

" Better location on home row.
noremap l h
noremap ; l
noremap h ;

autocmd FileType sh,zsh,csh,tcsh,bash if &modifiable|setlocal fileformat=unix|endif

" RST tables
autocmd FileType rst,py if &modifiable|let g:table_mode_corner='+' g:table_mode_header_fillchar='='|endif

set encoding=utf-8

let g:pymode_line = 0

" remove automatic line numbers and put everything else back
let g:pymode_options = 0
setlocal complete+=t
setlocal formatoptions-=t
setlocal nowrap
setlocal textwidth=79
setlocal commentstring=#%s
setlocal define=^\s*\\(def\\\\|class\\)

" Allow ,w to switch panes since Ctrl-w is interpreted by Chrome.
noremap <leader>w <C-w><C-w>

" Highlight non-ascii characters
syntax match nonascii "[^\x00-\x7F]"
highlight nonascii guibg=Red ctermbg=2


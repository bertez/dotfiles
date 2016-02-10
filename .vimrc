" Incompatible co pasado
set nocompatible
 
filetype plugin indent on
 
syntax enable
 
" asigna o leader á coma
let mapleader=','
 
" carga automaticamente os ficheiros que cambiaron
set autoread
 
" fai que a seguinte liña pille o indent da anterior
set autoindent
 
" encoding por defecto
set encoding=utf-8
 
"permite buffers ocultos
set hidden
 
" fai que comece a facer scroll 3 liñas antes do borde da pax
set scrolloff=3
 
" a ultima liña da ventana é a liña de comandos
set showcmd
 
" destaca o parentesis ou chave correspodente
set showmatch
 
" non corta as liñas longas
set nowrap
 
" como se composta o borrado no modo insert (salta a liña anterior e iso)
set backspace=indent,eol,start
 
" números de liña
set number
 
" redondea o indent
set shiftround
 
" ignora maiusculas e minusculas
set ignorecase
 
" se hai maiusculas no que busca non aplica ignorecase
set smartcase
 
" destaca os resultados da busca
set hlsearch
 
" busca segundo escribes
set incsearch
 
" recorda mil comandos
set history=1000
 
" mil niveis de undo
set undolevels=1000
 
" cambialle o titulo á ventana (se é aplicable)
set title
 
" avisos visuais
set visualbell
 
" non maree con feedback visual
set noerrorbells
 
" mostra e di que caracteres invisibles se mostran
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
 
"destaca a liña do cursor
set cursorline
 
" asume un terminal rápido e fai redraws máis rápido
set ttyfast
 
" fai backups e di onde facelos
set backup
set backupdir=~/.vim/backup
 
" non usa ficheiros de swap
set noswapfile
 
" xestiona as diferencias entre formatos de ficheiros
set fileformats=unix,dos,mac
 
" mostra sempre statusline
set laststatus=2
 
" expande as tabs en espacios e configura o espaciado
set expandtab
set softtabstop=4 tabstop=4 shiftwidth=4
 
" mostra info da posición na liña de status
set ruler
 
" xestiona como se abren os ficheiros e autocompletado
set wildignore=*.swp,*.bak,*.pyc
set wildmenu
set wildmode=list:longest,full
 
" configura como se fai o formateo automatico (gq)
set formatoptions=qrn1
 
" evita o folding, todo manual
set foldmethod=manual
set nofoldenable
set foldlevelstart=99
set foldlevel=99
 
" evita pulsar enter en moitas mensaxes
set shortmess+=filmnrxoOtT
 
" fai menos redraws
set lazyredraw
 
" salt 4 liñas cando fai scroll
set scrolljump=4
 
" permite o uso do rato
set mouse=a
 
" permite moverse 1 caracter máis de cada liña
set virtualedit=onemore
 
" configura que teclas permiten saltar de liña en liña
set whichwrap=b,s,h,l,<,>,[,]
 
" pon unha guia na liña 80
set cc=80
 
" permite tabular en modo visual
vnoremap < <gv
vnoremap > >gv
 
" garda posición do cursor ainda que se peche
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
 
" garda undo despois de pechar
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
 
" nada de teclas de cursor, só jkhl
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
 
" j e k leva á mesma posición da liña anterior
nnoremap j gj
nnoremap k gk
 
" leader coma quita os hilights
nnoremap <leader><space> :noh<cr>
 
" busca a palabra que hai baixo o cursor
nmap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
 
" quita os números de liña e ponos de novo
nmap <leader>n :set nonumber!<CR>
 
" escapa da liña de comandos elegantemente
cmap <C-g> <C-u><ESC>
 
" xestiona os erros de :WQ e :E
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
 
" jj en en modo insert fan escape
imap jj <Esc>
 
" control h e control l movense polos buffers
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
 
" novo, pechar e rotar tab
nmap <C-t> :tabnew<CR>
nmap <C-x> :tabclose<CR>
nmap <C-j> :tabprevious<CR>
nmap <C-k> :tabnext<CR>
 
" esquece este buffer
nmap <C-d> :bw<CR>
vmap <C-d> :bw<CR>
 
" pasa a modo paste
nnoremap <leader>p :set invpaste paste?<CR>
set pastetoggle=<leader>p
set showmode

" cousas do colorscheme
set background=dark
set t_Co=256
colorscheme Tomorrow-Night
 
" completa as funcións de python mellor
au FileType python set omnifunc=pythoncomplete#Complete
set completeopt=menuone,longest,preview

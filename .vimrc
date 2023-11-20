set nocompatible
let mapleader=","

" Helps force plugins to load correctly when it is turned back on below
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/nerdtree
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'davidhalter/jedi-vim'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'preservim/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ryanoasis/vim-devicons'
" All of your Plugins must be added before the following line
call vundle#end()            " required
set omnifunc=jedi#completions
let g:jedi#force_py_version = '3'
let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_autoclose=0

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
nnoremap <leader>f :NERDTreeFocus<CR>
" open terminal below all splits

cabbrev bterm bo term
let g:termsize=float2nr(round(winheight(0)*0.35))
execute "set termwinsize=" . termsize . "x0"
tnoremap <silent> <c-k> <C-w>k
tnoremap <silent> <c-j> <C-w>j
tnoremap <silent> <c-h> <C-w>h
tnoremap <silent> <c-l> <C-w>l
nnoremap = :call CorrectTermSize()<CR>

function! CorrectTermSize()
    echo "fixed termsize"
    let s:termh=float2nr(winheight(0))
    execute "set termwinsize=" . s:termh . "x0"
endfunction
"
" + toggle remap arrow keys to resize windows
"
nnoremap + :call ToggleResizeMode()<CR>

let s:KeyResizeEnabled = 0
let ResizeDelta = 10

function! ToggleResizeMode()
  if s:KeyResizeEnabled
    call NormalMotionKeys()
    let s:KeyResizeEnabled = 0
  else
    call ResizeMotionKeys()
    let s:KeyResizeEnabled = 1
  endif
endfunction

function! NormalMotionKeys()
  " unmap arrow keys
  echo 'normal motion keys'
  nnoremap j gj
  nnoremap k gk
  nunmap h
  nunmap l
endfunction

function! ResizeKey(key)
   if a:key is "k"
       execute "resize +5"
   elseif a:key is "j"
       execute "resize -5"
   elseif a:key is "h"
       execute "vertical resize -5"
   elseif a:key is "l"
       execute "vertical resize +5"
   else
       echo "unsupported key " . a:key
   endif 

   let s:termh=float2nr(winheight(0))
   execute "set termwinsize=" . s:termh . "x0"
endfunction
function! ResizeMotionKeys()
  " Remap arrow keys to resize window
  echo 'Resize window with hjkl keys'
  nnoremap k :call ResizeKey("k")<CR>
  nnoremap j :call ResizeKey("j")<CR>
  nnoremap h :call ResizeKey("h")<CR>
  nnoremap l :call ResizeKey("l")<CR>
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on


" Security
set modelines=0


" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=80
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set noshiftround


" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
" nnoremap / /\v
" vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set incsearch " show search results as you type
map <leader><space> :let @/=''<cr> " clear search

" Show line numbers
set number
set relativenumber

" remaps
tnoremap jk <C-\><C-n>
inoremap jk <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""
" Use  Alt-[jk] to move page without moving cursor

nmap <silent> j M 5<c-e>
nmap <silent> k M 5<c-y>

" Remap help ke4y.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme afterglow 
hi Normal guibg=NONE ctermbg=NONE

set timeoutlen=400
set noic


" spelling stuff
set spelllang=en_gb

nmap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nmap <Leader>pp :RunSilent evince /tmp/vim-pandoc-out.pdf<CR>

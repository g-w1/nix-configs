"""""""" leader
let mapleader =" "
""""""""""""""" cursors
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
endif
"'''''''''''''''''""" plugins
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" html tags
Plug 'gregsexton/MatchTag'
" ez!!!
Plug 'g-w1/ez.vim'
" haskell
Plug 'neovimhaskell/haskell-vim'
" toml
Plug 'cespare/vim-toml'
" jinja2
Plug 'lepture/vim-jinja'
" latex auto completion
Plug 'lervag/vimtex'
" for vue.js
Plug 'posva/vim-vue'
" fuzzy file search. really nice
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" gotta have tpope stuff
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" zig.vim for zig
Plug 'ziglang/zig.vim'
" nix files
Plug 'LnL7/vim-nix'
" writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" colorscheme
Plug 'chriskempson/base16-vim'
" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vim tmux
Plug 'christoomey/vim-tmux-navigator'
" git stuff
Plug 'https://github.com/tpope/vim-fugitive'
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""' " stuffff for plugins
set completeopt=noinsert,menuone,noselect
set shortmess+=c
" go to definition
nmap <silent> gd <Plug>(coc-definition)
" rename
nmap <silent> <leader>cr <Plug>(coc-rename)
nmap <silent> <leader>ca :CocAction<CR>
" go to errors next
nmap <silent> <leader>e <Plug>(coc-diagnostic-next)
nmap <silent> <leader>E <Plug>(coc-diagnostic-prev)
" better brackets
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

let g:coc_snippet_next = "<TAB>"
let g:coc_snippet_prev = "c-b"

" git stuff
nnoremap <leader>gg :Git<CR>

" terminal mode
" augroup terminal_settings
"   autocmd!

"   autocmd BufWinEnter,WinEnter term://* startinsert
"   autocmd BufLeave term://* stopinsert


"   au TermOpen * tnoremap <Esc> <c-\><c-n>
"   au FileType fzf tunmap <Esc>

"   " Ignore various filetypes as those will close terminal automatically
"   " Ignore fzf, ranger, coc
"   autocmd TermClose term://*
"         \ if (expand('<afile>') !~ "fzf") && (expand('<afile>') !~ "ranger") && (expand('<afile>') !~ "coc") |
"         \   call nvim_input('<CR>')  |
"         \ endif
" augroup END

" ezzzzzzzzzz (i made this lang up)
autocmd BufNewFile,BufRead *.ez set commentstring=[%s]
" for python in async
let $PYTHONUNBUFFERED=1
" for limelight
	let g:limelight_conceal_ctermfg = 'gray'
" textyank highlight
au TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank()
" vimtex
let g:tex_flavor = 'latex'
" fzf
map <leader><space> :GFiles<CR>
map <leader>/ :Rg<CR>
map <leader>, :Buffers<CR>

let g:fzf_buffers_jump = 1
let g:fzf_layout = {'down': '~30%'}
" airline/gui
let g:airline#extensions#tabline#enabled = 1
set bg=light
set go=a
set mouse=a
" searching
	set hlsearch
	set ignorecase
	set smartcase
	nnoremap <esc> :nohlsearch<cr>a<ESC>
" terminals
	nnoremap <leader>ot :sp<cr>:terminal<cr>:resize 10<cr>
	nnoremap <leader>oT :terminal<cr>
" better Y
    nnoremap Y y$

" tabs
set tabstop=4
set shiftwidth=2
set expandtab
set noemoji
set clipboard+=unnamedplus
set autoread
" Some basics:
	" nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
" Enable autocompletion:
	set wildmode=longest,list,full
" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is retarded, unlike vim defaults.
	set splitbelow splitright
" mapping j to gj for writing prose
	autocmd FileType tex map j gj
	autocmd FileType tex map k gk
	autocmd FileType markdown map j gj
	autocmd FileType markdown map k gk
	autocmd FileType mail map j gj
	autocmd FileType mail map k gk

  autocmd FileType c set noexpandtab
" writing:
	map <leader>g :Goyo<CR>
	autocmd! User GoyoEnter Limelight; hi Normal guibg=NONE ctermbg=NONE
	autocmd! User GoyoLeave Limelight!; hi Normal guibg=NONE ctermbg=NONE
" tera html templates
autocmd BufNewFile,BufRead *.tera set syntax=html

" buffers
nnoremap <leader>bk :bd<cr>

" Shortcutting split navigation, saving a keypress:
" dont need anymore because i use the tmux integrateion
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
	map <leader>wh <C-w>h
	map <leader>wj <C-w>j
	map <leader>wk <C-w>k
	map <leader>wl <C-w>l
	map <leader>wd :q<CR>
" Replace ex mode with gq
	map Q gq

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %
"spell checking
	autocmd FileType tex set spell
	autocmd FileType markdown set spell
	autocmd FileType mail set spell
	autocmd FileType text set spell
" Ensure files are read as what I want:
" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif
""""""""""""""""'  undofile
" history for undo
set undofile
set undodir=/home/jacob/.config/nvim/vimundo/
" map ;w to update
nmap ;w :w<CR>
"""""""""""""""""' italics
set t_ZH=^[[3m
set t_ZR=^[[23m
highlight Comment cterm=italic
""""""""" colortheme
colorscheme base16-gruvbox-dark-soft
let g:airline_theme='sol'
set termguicolors
" no background
hi Normal guibg=NONE ctermbg=NONE
""""""""""""" misc looks
set cursorline
" ocaml indent ????
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" autocmd FileType ocaml source g:opamshare . '/ocp-indent/vim/indent/ocaml.vim'

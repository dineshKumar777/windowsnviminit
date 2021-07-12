""""""""""""""""""""""""""""""""""""""""""""""""
" 	DEFAULT SETTINGS FOR ME
""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set number
set mouse=a
set hidden
syntax on
set lazyredraw
set updatetime=250
set scrolloff=5
set history=100
set nowrap

set encoding=utf-8
set clipboard=unnamed
if(has("termguicolors"))
	set termguicolors
endif

" Indents
set tabstop=2 shiftwidth=2
set smarttab
set smartindent
set autoindent

" Backup
set nobackup
set writebackup
set noswapfile
set noundofile

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

set splitbelow splitright

set shortmess+=c

filetype plugin indent on

" Format document and go back to orginial line
map <F7> gg=G<C-o>

if has ('autocmd') " Remain compatible with earlier versions
	augroup vimrc     " Source vim configuration upon save
		autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
		autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
	augroup END
endif " has autocmd

let mapleader=" "
nnoremap <leader>s <cmd>write<CR>
nnoremap <leader>q <cmd>quit<CR>
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader><leader> <cmd>:b#<CR>
nnoremap <leader>x <cmd>:qa!<CR>

nnoremap ; :
vnoremap ; :

" Move between windows
nmap <up> <C-w><up>
nmap <down> <C-w><down>
nmap <left> <C-w><left>
nmap <right> <C-w><right>
""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Hack:h14
" set guifont=Jetbrains\ Mono:h12


" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

""""""""""""""""""""""""""""""""""""""""""""""""
" 	UTILTIES AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""
" https://gist.github.com/jdhao/d592ba03a8862628f31cba5144ea04c2

" Do not use smart case in commandlne mode.
augroup dynamic_smartcase
	autocmd!
	autocmd CmdLineEnter : set nosmartcase
	autocmd CmdLineLeave : set smartcase
augroup END

" Term settings
augroup term_settings
	autocmd!
	autocmd TermOpen * setlocal norelativenumber nonumber
	autocmd TermOpen * startinsert
augroup END

" Display msg when the current file is not in UTF-8 format
augroup non_utf8_file_warn
	autocmd!
	autocmd BufRead * if &fileencoding != 'utf-8'
				\ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

" https://stackoverflow.com/a/3879737
" Create command alias safely
fun! Cabbrev(from, to)
	exec 'cnoreabbrev <expr> '.a:from
				\ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
				\ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" https://stackoverflow.com/a/5703164
fun! HasColorscheme(name) abort
	let l:pat = printf('colors/%s.vim', a:name)
	return !empty(globpath(&runtimepath, l:pat))
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""
" 	PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin("~/.vim/plugged")
Plug 'lifepillar/vim-gruvbox8'
Plug 'b3nj5m1n/kommentary'
Plug 'szw/vim-maximizer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'jghauser/mkdir.nvim'
call plug#end()


" Use shortnames for common vimplug to reduce typing
let g:plug_window = 'new' "Open pluginstall in new buffer horizontal split
call Cabbrev('pi', 'PlugInstall')
call Cabbrev('pud', 'PlugUpdate')
call Cabbrev('pug', 'PlugUpgrade')
call Cabbrev('ps', 'PlugStatus')
call Cabbrev('pc', 'PlugClean')

" Gruvbox settings
if HasColorscheme('gruvbox8')
	" Italic options should be put before colorscheme setting,
	" see https://goo.gl/8nXhcp
	let g:gruvbox_italics=1
	let g:gruvbox_italicize_strings=1
	let g:gruvbox_filetype_hi_groups = 0
	let g:gruvbox_plugin_hi_groups = 0
	set background=dark
	colorscheme gruvbox8_soft
else
	colorscheme default
endif

" Default mappings with plugins
" maximizer => f3
" kommentry => gcc


lua << EOF
require('neovide')
require('lsp')
require('treesitter')
require('completion')
require('autopairs')
require('telescope')
require('mkdir') -- this is for plugin load
EOF


" Include these into completion.lua config instead of init.vim
inoremap <silent><expr> <C-Space> compe#complete()
" inoremap <silent><expr> <CR>      compe#confirm('<CR>') "remapped in
" completion
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" Snippet configuration is pending

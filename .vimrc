set nocompatible              				" required
filetype off                  				" required

set rtp+=~/.vim/bundle/Vundle.vim  			" set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'mhartington/oceanic-next'
Plugin 'vim-airline/vim-airline'
Plugin 'ryanoasis/vim-devicons'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/syntastic'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'pangloss/vim-javascript'

call vundle#end()            				" required
filetype plugin indent on    				" required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ

set encoding=utf8

set statusline=+'%<\ %f\ %{fugitive#statusline()}'

" Theme
syntax enable
set t_Co=256
colorscheme OceanicNext
set background=dark

let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1

set guifont=SauceCodePro\ Nerd\ Font\ Regular:h11

set tabstop=4
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a tab
set expandtab       " Expand tabs to spaces

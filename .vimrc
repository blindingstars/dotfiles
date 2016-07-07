source bundles.vim

set encoding=utf8

" my configuration which depends on bundles
set statusline=+'%<\ %f\ %{fugitive#statusline()}'

" Theme
syntax enable
set t_Co=256
colorscheme OceanicNext
set background=dark

let g:airline_theme='oceanicnext'
let g:airline_powerline_fonts = 1

set guifont=SauceCodePro\ Nerd\ Font\ Regular:h11

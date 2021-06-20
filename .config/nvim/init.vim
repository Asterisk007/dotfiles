filetype plugin on

call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tjdevries/colorbuddy.vim'
Plug 'tjdevries/gruvbuddy.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'
Plug 'Shougo/echodoc.vim'
Plug 'edluffy/specs.nvim'
Plug 'mhinz/vim-startify'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'artanikin/vim-synthwave84'
call plug#end()

"lua require('colorbuddy').colorscheme('gruvbuddy')

set number
set relativenumber
set termguicolors

let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 0

colorscheme synthwave84

" specs settings
lua << EOF
require('specs').setup{
    show_jumps = true,
    min_jump = 30,
    popup = {
        inc_ms = 30,
        blend = 20,
        width = 10,
        winhl = "Pmenu",
        fader = require('specs').linear_fader,
        resizer = require('specs').shrink_resizer
    }
}
EOF

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nohlsearch
set nowrap
set guicursor=
set mouse=a

set cmdheight=1
set updatetime=300

set laststatus=2
set noshowmode

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch

set scrolloff=8
set signcolumn=yes

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

syntax enable

let s:clip = '/mnt/c/Windows/System32/clip.exe' 
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
	augroup END
end

let g:lightline = {
    \ 'colorscheme': 'ayu_dark',
    \ }
let g:vimfiler_as_default_explorer = 1

autocmd FileType json syntax match Comment +\/\/.\+$+

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> <F3> :VimFilerExplorer -toggle<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use Ctrl-Alt-i to show documentation in preview window
nnoremap <silent> <C-A-i> :call <SID>show_documentation()<CR>

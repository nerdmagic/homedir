syntax on
set nocompatible
filetype off
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set smartindent
set title
set t_Co=256

map <silent> <C-t> :NERDTreeToggle<CR>
map <silent> <C-p> :CtrlP<CR>
map <silent> <C-n> :set invnumber<CR>

" crosshair
hi CursorLine cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
set cursorline! cursorcolumn!
nmap <silent> <Leader>c :set cursorline! cursorcolumn!<CR>

hi LineNr ctermfg=black ctermbg=235

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My bundles here:
"
" original repos on GitHub
Plugin 'rodjek/vim-puppet'
Plugin 'tmhedberg/SimpylFold'

"Plugin 'ervandew/supertab'
"Plugin 'godlygeek/tabular'
"Plugin 'scrooloose/nerdtree'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Plugin 'scrooloose/syntastic'
"Plugin 'kien/ctrlp.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()

filetype plugin indent on     " required!

" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

autocmd VimEnter * if !argc() | NERDTree | endif
"autocmd VimEnter * wincmd p

set laststatus=2

set statusline=***\ %<%F
set statusline+=%=
set statusline+=%l/%L%4c

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"let g:syntastic_auto_jump=1
"let g:syntastic_auto_loc_list=1

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore .DS_Store --ignore "" ~/puppet-modules'

"shortcut keybindings for split navigation
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

"colorscheme gardener
hi NonText   cterm=NONE ctermbg=233
hi StatusLine ctermfg=7

au BufNewFile,BufRead *.py
\ set tabstop=4 |
\ set softtabstop=4 |
\ set shiftwidth=4 |
\ set textwidth=79 |
\ set expandtab |
\ set autoindent |
\ set fileformat=unix

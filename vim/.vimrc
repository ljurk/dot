set laststatus=2
set t_Co=256
set shell=zsh

syntax on
filetype plugin on
set nocompatible
set number
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:^

" vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'vimwiki/vimwiki'
    Plug 'airblade/vim-gitgutter'
    Plug 'Valloric/YouCompleteMe'
    Plug 'dense-analysis/ale'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    Plug 'kien/ctrlp.vim'
    Plug 'thinca/vim-quickrun'
    Plug 'schickele/vim-nachtleben'
    " optional
    "Plug 'mattn/emmet-vim'
    "Plug 'fatih/vim-go'
    "Plug 'https://github.com/jamessan/vim-gnupg'
call plug#end()

"ale
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%:%code%]  %s [%severity%]'
let g:ale_linters = {
\   'python': ['flake8','pylint'],
\   'cpp': ['cpplint'],
\   'yml': ['ansible-lint'],
\   'js': ['eslint'],
\   'css': ['stylelint'],
\}

let mapleader = ","

" quickrun
map <F5> :QuickRun<cr>
nnoremap <F6> :bw! quickrun://output<cr>

" recommandations from https://realpython.com/vim-and-python-a-match-made-in-heaven/
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>y "+y
map <leader>Y "+Y

" color it up
color nachtleben
set cursorline
hi CursorLine   cterm=NONE ctermbg=18 ctermfg=NONE
" vimdiff colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
" tab settings
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
" cursor in center
set so=999
" disable ex mode
map q: <Nop>
nnoremap Q <nop>

" buffers
nnoremap H :bnext<Enter>
nnoremap L :bprevious<Enter>
nnoremap <leader>b :CtrlPBuffer<Enter>
nnoremap <leader>l :CtrlP .<Enter>

" page up/down
let g:BASH_Ctrl_j = 'off'
nnoremap <C-j> <C-d>
nnoremap <C-k> <C-u>
" folds
nnoremap <SPACE> za
let g:SimpylFold_docstring_preview = 0
" navigate in splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" some usefull functions
nnoremap <F1> :NERDTreeToggle<Enter>
nnoremap <F2> :set list!<Enter>
nnoremap <F3> :set relativenumber!<Enter>
nnoremap <F7> :ALEDetail <ENTER>
" fix all spell erros with first alternative
nnoremap <F8> :%normal ]s1z=<ENTER>

" Enable autocompletion:
    set wildmode=longest,list,full

" filetypes for vimwiki
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown',
                          \ '.rmd': 'markdown',
                          \ '.md': 'markdown',
                          \ '.markdown': 'markdown',
                          \ '.mdown': 'markdown'}


"configurations based on filetype
"""folding
autocmd FileType python setlocal foldmethod=indent

"""spellchecking
autocmd FileType markdown setlocal spell

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

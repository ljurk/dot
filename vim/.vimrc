set laststatus=2
set t_Co=256

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

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif

let mapleader = ","
" recommandations from https://realpython.com/vim-and-python-a-match-made-in-heaven/
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" color it up
    color nachtleben
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
" tab settings
    set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" cursor in center
    set so=999
" disable ex mode
    map q: <Nop>
    nnoremap Q <nop>
" folding, only works if the opening bracket of a funtions is the only char on
" the line
    nnoremap <F4> ?\/\*\\|^{<ENTER>zf%
    nnoremap <F7> :%g/^{\\|\/\*/normal! zf%<ENTER>
" highlight cursor line
    set cursorline
" swtich between tabs
    nnoremap H gT
    nnoremap L gt
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
    nnoremap <F6> :make clean<ENTER>
    nnoremap <F5> :w<ENTER>:make<ENTER>
    nnoremap <F7> :ALEDetail <ENTER>
" move text to 0,0+4 Spaces,0+8Spaces
    nnoremap mt0 ^d0j
    nnoremap mt1 ^d0I    j
    nnoremap mt2 ^d0I        j
" macros for markdown
    nnoremap mdt ggi---title: <a href="https://303.ddns.net"><img src="smile.png" alt="drawing" width="100"/></a><++>---

" Enable autocompletion:
    set wildmode=longest,list,full

" filetypes for vimwiki
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}


"configurations based on filetype
"""folding
autocmd FileType python setlocal foldmethod=indent


" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

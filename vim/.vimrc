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
    Plug 'junegunn/fzf.vim'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'vimwiki/vimwiki'
    Plug 'airblade/vim-gitgutter'
    Plug 'Valloric/YouCompleteMe'
    Plug 'dense-analysis/ale'
    Plug 'tpope/vim-surround'
    Plug 'thinca/vim-quickrun'
    Plug 'schickele/vim-nachtleben'
    Plug 'fatih/vim-go'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    " preview for substitute
    Plug 'markonm/traces.vim'
call plug#end()

"ale
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%:%code%]  %s [%severity%]'
let g:ale_linters = {
\   'python': ['ruff'],
\   'cpp': ['cpplint'],
\   'yml': ['ansible-lint'],
\   'md': ['mdl'],
\   'js': ['eslint'],
\   'css': ['stylelint'],
\}
let b:ale_fixers = {
\   'python': ['remove_trailing_lines', 'trim_whitespace', 'ruff_format'],
\   'py': ['remove_trailing_lines', 'trim_whitespace', 'ruff_format'],
\   'yaml': ['remove_trailing_lines', 'trim_whitespace', 'prettier'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1

let mapleader = ","

" quickrun
map <F5> :QuickRun<cr>
nnoremap <F6> :bw! quickrun://output<cr>

" highlight search
set incsearch

" move visual selection up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" start substitute with word you are currently on
" nnoremap <leader>s [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]"
nnoremap <Leader>s :let @/ = '\<<C-r>=expand("<cword>")<CR>\>'<CR>:%s/<C-r>/<Left><Left>


" python
"autocmd BufWritePre *.py :silent! %!ruff format -- >/dev/null 2>&1

" go
":autocmd BufWritePre *.go :GoBuild
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
" auto close preview after selection
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" recommandations from https://realpython.com/vim-and-python-a-match-made-in-heaven/
"let g:go_def_mode='gopls'
"let g:ycm_autoclose_preview_window_after_completion=1
" Enable YCM
"let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" let g:ycm_semantic_triggers = {'go': ['.']}
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>y "+y
map <leader>Y "+Y

" quote words
:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P

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
" searching with f/F
" nnoremap n ;
" nnoremap N ,

" buffers
nnoremap H :bnext<Enter>
nnoremap L :bprevious<Enter>

"ALE
nnoremap ]d :ALENext<Enter>

" git
nmap <leader>gs :Git<Enter>
nmap <leader>gc :Git commit<Enter>
nmap <leader>gcn! :Git commit --no-edit --amend<Enter>
nmap <leader>ga :GitGutterStageHunk<Enter>
nmap <leader>gd :Git diff --cached<Enter>

" fzf
nmap <leader>b :Buffers<Enter>
nmap <leader>l :Files .<Enter>
nmap <leader>g :GFiles? <Enter>
nmap <leader>r :Rg<Enter>
" register
nnoremap <leader>p :<C-u>registers<CR>:normal! "p<Left>

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
autocmd FileType markdown setlocal spelllang=de_de,en_us


" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e

" switch buffers without saving
set hidden

" vagrant
au BufReadPost vagrantfile set syntax=ruby
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000

"set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
set rtp+=$HOME/.local/lib/python3.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_Co=256

syntax on
filetype plugin on
set nocompatible
set number
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:^

" vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'https://github.com/scrooloose/nerdtree.git'
    Plug 'vimwiki/vimwiki'
    Plug 'tmhedberg/SimpylFold'
call plug#end()

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif

" color it up
    color nachtleben
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
" move text to 0,0+4 Spaces,0+8Spaces
    nnoremap mt0 ^d0j
    nnoremap mt1 ^d0I    j
    nnoremap mt2 ^d0I        j
" remove trailing whitespaces
    nnoremap mrm :%s/\s\+$//e
" macros for markdown
    nnoremap mdt ggi---title: <a href="https://303.ddns.net"><img src="smile.png" alt="drawing" width="100"/></a><++>---

" Enable autocompletion:
    set wildmode=longest,list,full

" filetypes for vimwiki
    let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Navigating with guides
    inoremap <Space><Space> <Esc>/<++><Enter>"_c4l
"""PHP/HTML
    autocmd FileType php,html inoremap ,b <b></b><Space><++><Esc>FbT>i
    autocmd FileType php,html inoremap ,it <em></em><Space><++><Esc>FeT>i
    autocmd FileType php,html inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
    autocmd FileType php,html inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
    autocmd FileType php,html inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
    autocmd FileType php,html inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ,li <Esc>o<li></li><Esc>F>a
    autocmd FileType php,html inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
    autocmd FileType php,html inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
    autocmd FileType php,html inoremap ,td <td></td><++><Esc>Fdcit
    autocmd FileType php,html inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
    autocmd FileType php,html inoremap ,th <th></th><++><Esc>Fhcit
    autocmd FileType php,html inoremap ,tab <table><Enter></table><Esc>O
    autocmd FileType php,html inoremap ,gr <font color="green"></font><Esc>F>a
    autocmd FileType php,html inoremap ,rd <font color="red"></font><Esc>F>a
    autocmd FileType php,html inoremap ,yl <font color="yellow"></font><Esc>F>a
    autocmd FileType php,html inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
    autocmd FileType php,html inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
    autocmd FileType php,html inoremap &<space> &amp;<space>

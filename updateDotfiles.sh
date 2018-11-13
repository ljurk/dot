#!/bin/bash
#move old files
if [ $1 == "keepold" ]
then
    mv ~/.tmux.conf ~/.tmux.conf.old
    mv ~/.vimrc ~/.vimrc.old
    mv ~/.bashrc ~/.bashrc.old
    mv ~/.vim ~/.vim.old
    mv ~/.config ~/.config.old
fi

if [ $1 == "deleteold" ]
then
    rm -f ~/.tmux.conf.old
    rm -f ~/.vimrc.old
    rm -f ~/.bashrc.old
    rm -f ~/.vim.old
    rm -f ~/.config.old
fi


    rm -f ~/.vim
    rm -f ~/.config
#link to new files
printf "so /home/ljurk/dotfiles/vimrc" > ~/.vimrc
printf "source-file /home/ljurk/dotfiles/tmux.conf" > ~/.tmux.conf
printf "source /home/ljurk/dotfiles/bashrc" > ~/.bashrc
printf "source /home/ljurk/dotfiles/bash_profile" > ~/.bash_profile

ln -s /home/ljurk/dotfiles/.vim/ ~/.vim
ln -s /home/ljurk/dotfiles/.config ~/.config

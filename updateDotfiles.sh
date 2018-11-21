#!/bin/bash
#move old files
if [ $1 == "keepold" ]
then
    mv ~/.tmux.conf ~/.tmux.conf.old
    mv ~/.vimrc ~/.vimrc.old
    mv ~/.bashrc ~/.bashrc.old
    mv ~/.vim ~/.vim.old
    mv ~/.config ~/.config.old
else
    rm -f ~/.tmux.conf
    rm -f ~/.vimrc
    rm -f ~/.bashrc
    rm -f ~/.bash_profile
    rm -rf ~/.vim
    rm -rf ~/.config/powerline
fi


#link to new files
printf "so /home/ljurk/dotfiles/vimrc" > ~/.vimrc
printf "source-file /home/ljurk/dotfiles/tmux.conf" > ~/.tmux.conf
printf "source /home/ljurk/dotfiles/bashrc" > ~/.bashrc
printf "source /home/ljurk/dotfiles/bash_profile" > ~/.bash_profile

ln -s /home/ljurk/dotfiles/.vim/ ~/.vim
ln -s /home/ljurk/dotfiles/.config/powerline ~/.config/powerline

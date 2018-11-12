#!/bin/bash
#move old files
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.vimrc ~/.vimrc.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.vim ~/.vim.old
mv ~/.config ~/.config.old

#link to new files
printf "so /home/ljurk/dotfiles/vimrc" > ~/.vimrc
printf "source-file /home/ljurk/dotfiles/tmux.conf" > ~/.tmux.conf
printf "source /home/ljurk/dotfiles/bashrc" > ~/.bashrc

ln -s /home/ljurk/dotfiles/.vim/ ~/.vim
ln -s /home/ljurk/dotfiles/.config ~/.config

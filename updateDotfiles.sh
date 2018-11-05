#!/bin/bash
for D in `find . -name ".*" -not -path "./.git" `
do
    echo $D
done
#move old files
mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.vimrc ~/.vimrc.old
mv ~/.bashrc ~/.bashrc.old
mv ~/.vim ~/.vim.old
mv ~/.config ~/.config.old

#link to new files
printf "so $HOME/dotfiles/vimrc" > ~/.vimrc
printf "source-file $HOME/dotfiles/tmux.conf" > ~/.tmux.conf
printf "source $HOME/dotfiles/bashrc" > ~/.bashrc

ln -s $HOME/dotfiles/.vim/ ~/.vim
ln -s $HOME/dotfiles/.config ~/.config

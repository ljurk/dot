#!/bin/bash
for D in `find . -name ".*" -not -path "./.git" `
do
    echo $D
done

mv ~/.tmux.conf ~/.tmux.conf.old
mv ~/.vimrc ~/.vimrc.old
mv ~/.bashrc ~/.bashrc.old

printf "so $HOME/dotfiles/vimrc" > ~/.vimrc
printf "source-file $HOME/dotfiles/tmux.conf" > ~/.tmux.conf
printf "source $HOME/dotfiles/bashrc" > ~/.bashrc
ln -s dotfiles/.vim/ .vim


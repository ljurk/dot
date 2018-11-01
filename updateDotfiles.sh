#!/bin/bash
for D in `find . -name ".*" -not -path "./.git" `
do
    echo $D
done
cp ./.tmux.conf ~/.tmux.conf



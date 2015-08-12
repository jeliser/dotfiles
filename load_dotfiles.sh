#!/bin/bash
dotfiles -s -R `pwd`/dotfiles --force
mv ~/.gitconfig.public ~/.gitconfig

mkdir -p ~/.vim/.undodir;
mkdir -p ~/.vim/backup;
mkdir -p ~/.vim/autoload;


#!/bin/bash
dotfiles -s -R `pwd`/dotfiles --force
if [ -f "$HOME/.gitconfig.public" ] && ! [ -f "$HOME/.gitconfig" ] ; then
  cp $HOME/.gitconfig.public $HOME/.gitconfig
fi

mkdir -p ~/.vim/.undodir;
mkdir -p ~/.vim/backup;
mkdir -p ~/.vim/autoload;


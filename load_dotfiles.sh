#!/bin/bash
dotfiles -s -R `pwd`/dotfiles --force
if [ -f "$HOME/.gitconfig.public" ] && ! [ -f "$HOME/.gitconfig" ] ; then
  cp $HOME/.gitconfig.public $HOME/.gitconfig
fi

mkdir -p ~/.vim/local/backup;
mkdir -p ~/.vim/local/swap;
mkdir -p ~/.vim/local/undo;
mkdir -p ~/.vim/local/view;
mkdir -p ~/.vim/autoload;

## Create the Vundle directory and install all bundles
rm -rf ~/.vim/bundle/vundle && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle --quiet
vim +PluginInstall +qall

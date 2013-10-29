#!/usr/bin/env sh

if [ ! -e $HOME/.vim/bundle/vundle ]; then
  echo "Installing Vundle"
  git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u `pwd`/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell

# Install dependacies for YouCompleteMe
bash -c "cd $HOME/.vim/bundle/YouCompleteMe; ./install.sh"

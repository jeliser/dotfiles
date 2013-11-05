#!/usr/bin/env sh

# Put this in a script like:  install_vim_from_source
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xvjf vim-7.4.tar.bz2
cd vim74
# Determine is yum or apt-get should be called
sudo yum install ncurses-devel
./configure --enable-pythoninterp --enable-multibyte --with-tlib=ncurses
make -j 10; sudo make install


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

#!/usr/bin/env sh

# Put this in a script like:  install_vim_from_source
#wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
#tar xvjf vim-7.4.tar.bz2
#cd vim74
# Determine is yum or apt-get should be called
#sudo apt-get install ncurses-devel
#./configure --enable-pythoninterp --enable-multibyte --with-tlib=ncurses
#./configure --enable-pythoninterp --enable-multibyte --with-tlib=tinfo
#make -j 10; sudo make install
#cd ../


if [ ! -e $HOME/.vim/bundle/vundle ]; then
  echo "Installing Vundle"
  git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
system_shell=$SHELL
export SHELL="/bin/sh"
vim -u $HOME/.vimrc.bundles +BundleInstall! +BundleClean +qall
export SHELL=$system_shell

# Install dependacies for YouCompleteMe
# TODO: Check the dir or for a .install file to see if this should be executed
bash -c "cd $HOME/.vim/bundle/YouCompleteMe; ./install.sh"

# pathogen puts the .vim files in the vim path so methods can be executed
mkdir -p ~/.vim/.undodir;
mkdir -p ~/.vim/backup;
mkdir -p ~/.vim/autoload;
wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim -O ~/.vim/autoload/pathogen.vim


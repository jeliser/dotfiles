#!/bin/bash

set -eu

if [[ ! -f vim-7.4.tar.bz2 ]] ; then
  wget http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
fi

if [[ -d vim74 ]] ; then
  rm -rf vim74
fi
tar xvjf vim-7.4.tar.bz2
cd vim74

# TODO: Determine is yum or apt-get should be called
# Ubuntu
#sudo apt-get install ncurses-devel
#./configure --prefix=$HOME/local --enable-pythoninterp=yes --enable-multibyte=yes --with-tlib=ncurses --with-features=huge --enable-cscope=yes

# CentOS / Fedora
#sudo yum groupinstall 'Development tools' ncurses-devel
./configure --prefix=$HOME/local --enable-pythoninterp=yes --enable-multibyte=yes --with-tlib=tinfo --with-features=huge --enable-cscope=yes

make -j 10; make install
cd -



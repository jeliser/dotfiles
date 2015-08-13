#!/usr/bin/env sh

if [[ ! -f vim-7.4.tar.bz2 ]] ; then
  wget http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
fi

if [[ ! -d vim74 ]] ; then
  tar xvjf vim-7.4.tar.bz2
fi
cd vim74
# TODO: Determine is yum or apt-get should be called
#sudo apt-get install ncurses-devel
./configure --prefix=$HOME/local --enable-pythoninterp --enable-multibyte --with-tlib=ncurses --with-features=huge --enable-cscope
#./configure --prefix=$HOME/local --enable-pythoninterp --enable-multibyte --with-tlib=tinfo --with-features=huge --enable-cscope
make -j 10; make install
cd ../



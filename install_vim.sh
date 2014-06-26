#!/usr/bin/env sh

#wget http://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar xvjf vim-7.4.tar.bz2
cd vim74
# TODO: Determine is yum or apt-get should be called
#sudo apt-get install ncurses-devel
./configure --enable-pythoninterp --enable-multibyte --with-tlib=ncurses --with-features=huge --enable-cscope
#./configure --enable-pythoninterp --enable-multibyte --with-tlib=tinfo --with-features=huge --enable-cscope
make -j 10; sudo make install
cd ../



#!/bin/bash

VER=2.8.11

if [[ ! -f cmake-${VER}.tar.gz ]] ; then
  wget http://www.cmake.org/files/v2.8/cmake-${VER}.tar.gz
fi

if [[ -d cmake-${VER} ]] ; then
  rm -rf cmake-${VER}
fi

tar xzvf cmake-${VER}.tar.gz
cd cmake-${VER}/
./configure --prefix=/$HOME/local
make -j 10
make install
cd -


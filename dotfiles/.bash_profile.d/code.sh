#alias d='docker'

cl_show_rpath() { 
  readelf -a $1 | grep RUNPATH
}


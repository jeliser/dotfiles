#alias d='docker'

cl_show_rpath() { 
  readelf -a $1 | c++filt | grep RUNPATH
}

cl_nm_dump() {
  nm -gDC $@
}

cl_readelf_dump() {
  readelf -Ws $@ | c++filt
}

cl_objdump_dump() {
  objdump -TC $@
}

cl_objdump_linker() {
  objdump -p $@
}


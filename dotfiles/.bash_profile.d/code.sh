#alias d='docker'

cl_show_rpath() { 
  readelf -a $1 | grep RUNPATH
}

cl_nm_dump() {
  nm -gDC $@
}

cl_readelf_dump() {
  readelf -Ws $@
}

cl_objdump_dump() {
  objdump -TC $@
}


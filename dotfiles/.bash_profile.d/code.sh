#alias d='docker'

cl_show_rpath() { 
  readelf -a $1 2>&1 | c++filt | grep RUNPATH
}

cl_nm_dump() {
  nm -gDC $@ 2>&1
}

cl_readelf_dump() {
  readelf -Ws $@ 2>&1 | c++filt
}

cl_objdump_dump() {
  objdump -TC $@ 2>&1
}

cl_objdump_linker() {
  objdump -p $@ 2>&1
}

format_dat_code() {
  #git diff $1^..HEAD --name-only --diff-filter=A | grep -e "\.cc\|\.hh" | xargs clang-format -i
  #git diff $1^..HEAD --name-only --diff-filter=A | grep -e "\.cc\|\.hh" | xargs clang-format -i
  #find . -name "$1" | xargs clang-format -style=file -i
  find . | grep "$1" | xargs clang-format -style=file -i
}



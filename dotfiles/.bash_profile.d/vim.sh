
alias vimtab='vimtabs'
vimtabs() {
  FILELIST=$( echo "$@" | tr ' ' '\n' )
  FORALL=""
  CNT=1
  
  IFS=$'\n'
  for FILE in ${FILELIST}; do
    if [ ${CNT} -gt 1 ]; then
      FORALL=${FORALL}"|tabnew|"
    fi
    FORALL=${FORALL}"e ${FILE}"
    CNT=$((CNT+1))
  done

  vim -c "${FORALL}|tabn"
}


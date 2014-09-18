#!/bin/sh

blob_history() {
  # Modifed from this example:
  #  http://stackoverflow.com/questions/223678/which-commit-has-this-blob

  obj_name="$1"
  shift
  git log "$@" --pretty=format:'%T %h %ad %s' --date=short \
  | while read tree commit date subject ; do
      if git ls-tree -r $tree | grep -q "$obj_name" ; then
          echo $commit $date "$subject"
      fi
  done
}

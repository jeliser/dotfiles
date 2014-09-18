#!/bin/bash
git_size() {
  # http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pack-objects-and-trim-your-waist-line/
  
  # Search up the tree for the .git directory
  path=""
  i=0
  while [ $i -lt 20 ] && [ `find $path -type d | grep .git | wc -l` -eq 0 ]; do
    path+="../"
    let i+=1
  done

  # set the internal field spereator to line break, so that we can iterate easily over the verify-pack output
  IFS=$'\n';
   
  # list all objects including their size, sort by size, take top 10
  objects=`git verify-pack -v $path.git/objects/pack/pack-*.idx | grep -v chain | sort -k3nr | head -n $1 | tr -s ' '`
  echo "All sizes are in kB's. The pack column is the size of the object, compressed, inside the pack file."
   
  output="size,pack,SHA,location"
  for y in $objects
  do
    # extract the size in bytes
    size=$((`echo $y | cut -f 3 -d ' '`/1024))
    # extract the compressed size in bytes
    compressedSize=$((`echo $y | cut -f 4 -d ' '`/1024))
    # extract the SHA
    sha=`echo $y | cut -f 1 -d ' '`
    # find the objects location in the repository tree
    other=`git rev-list --all --objects | grep $sha`
    #lineBreak=cho -e "\n"
    output="${output}\n${size},${compressedSize},${other}"
  done
   
  echo -e $output | column -t -s ', '
}


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

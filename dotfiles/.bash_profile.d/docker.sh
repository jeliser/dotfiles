alias d='docker'
alias dc='docker container'
alias di='docker image'

docker_connect() { docker exec -it $@ /bin/bash; }

alias docker_attach='docker_connect'
alias da='docker_attach'

#docker_run() { docker run -u $(id -u ${USER}):$(id -g ${USER}) -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $@; }
docker_run() { docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix $@; }
alias dr='docker_run'
docker_bash() { docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --entrypoint "/bin/bash" $@; }
alias db='docker_bash'

docker_copy() {
  # Sanity check that an enviroment was set
  if [ "$#" -lt 2 ]; then
    echo "Please supply the docker container and source directory."
    echo "> docker_copy CONTAINER SOURCE [DESTINATION]"
    return
  fi

  IMAGE=$1
  SRC=$2
  DEST='./'
  if [ "$#" -eq 3 ]; then
    DEST=$3
  fi

  docker cp $(docker create --rm $IMAGE):$SRC $DEST
}
alias docker_cp='docker_copy'

docker_stop_all_containers() { echo $( docker ps -aq ) | xargs docker stop; echo $( docker ps -aq ); }
docker_prune_all_containers() { echo $( docker ps -aq ) | xargs docker stop; echo $( docker ps -aq ) | xargs docker rm -f; }
docker_prune_dangling_images() { docker system prune; }
docker_prune_all_images() { docker system prune -a; }

docker_new_instance() {
  # Check the wildcard case or the case where nothing was supplied.
  if [[ ( "$#" -lt 1 && "$#" -ge 1 ) || ( "$1" == "*" ) ]]; then
    echo "$( docker image list 2>>/dev/null )"
    echo "Please supply a more specific qualifier.  Too many matches found."
    return
  fi
  # Check that there is only a single matching image to create a container from
  if [ "$( docker image list $1 2>>/dev/null | wc -l )" -gt 2 ]; then
    echo "$( docker image list $1 2>>/dev/null )"
    echo "Please supply a more specific qualifier.  Too many matches found."
    return
  fi

  MATCH="$( docker image list $1 | head -n2 | tail -n1 )"
  IFS=' '
  read -a strarr <<< "${MATCH}"
  CONTAINER="${strarr[0]}:${strarr[1]}"
  echo "Loading: ${CONTAINER}"
  docker exec -it $( docker run -dit ${CONTAINER} bash ) /bin/bash;
}



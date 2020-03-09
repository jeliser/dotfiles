alias d='docker'
alias dc='docker container'
alias di='docker image'

docker_prune_all_containers() { echo $( docker ps -aq ) | xargs docker stop; echo $( docker ps -aq ) | xargs docker rm;}
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

docker_connect() { docker exec -it $@ /bin/bash; }

alias docker_attach='docker_connect'
alias da='docker_attach'

docker_bash() { docker run -it $@; }
alias db='docker_bash'


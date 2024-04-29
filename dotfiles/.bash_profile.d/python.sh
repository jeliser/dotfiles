alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

create_ve() {
  # Sanity check that an enviroment was set
  if [ "$#" -lt 1 ]; then
    echo "Please supply python environment to create."
    return
  fi

  PYTHON=$( readlink -f $( which python3 ) )
  if [ "$#" -eq 2 ]; then
    PYTHON=$2
  fi

  deactivate 2>/dev/null;
  rm -rf ~/.python_env/$1;
  virtualenv -p ${PYTHON} ~/.python_env/$1 && ve $1;
}
alias cve='create_ve'

delete_ve() {
  rm -rf ~/.python_env
}
alias dve='delete_ve'

start_ve() {
  create_ve $( basename $( pwd ) )
  pip install -r requirements.txt
}
alias sve='start_ve'

ve() { source ~/.python_env/$1/bin/activate; }

pypi_cache() {
  if [ $( pip freeze | grep proxpi | wc -l ) -lt 1 ]; then
    pip --isolated install proxpi
  fi

  PROXPI_CACHE_DIR=~/.pypi_cache FLASK_APP=proxpi.server flask run >> /tmp/proxpi.log 2>&1 &
}

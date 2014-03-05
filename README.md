# Josh's Dotfiles

## Description

The newest revision of my dotfiles managed using [dotfiles](https://github.com/jbernard/dotfiles).  Thanks to [mjcarroll](https://github.com/mjcarroll/dotfiles) for the inspiration.


## Installation bits

### Necessary for dotfiles

    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install git python-pip build-essential cmake python-dev



### Dotfiles

    sudo pip install dotfiles
    git clone https://github.com/jeliser/dotfiles ~/.dotfiles_devel
    dotfiles -s -R ~/.dotfiles_devel/dotfiles --force

    cd ~/.dotfiles_devel
    ./bootstrap_vim.sh



# Josh's Dotfiles

## Description

The newest revision of my dotfiles.  Managed using
[dotfiles](https://github.com/jbernard/dotfiles).


## Installation bits

### Necessary for dotfiles

    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install vim vim-gtk git tig git-gui git-svn gitk python-pip \
    suckless-tools dwm dmenu ack build-essential gufw keychain openssh-server 



### Dotfiles

    sudo pip install dotfiles
    mkdir -p ~/.dotfiles_devel
    git clone https://github.com/jeliser/dotfiles ~/.dotfiles_devel
    dotfiles -s -R ~/.dotfiles_devel --force

    cd ~/.dotfiles_devel
    ./bootstrap_vim.sh
    git submodule init && git submodule update



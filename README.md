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
    mkdir -p ~/devel/Dotfiles
    git clone https://github.com/jeliser/dotfiles ~/devel/Dotfiles
    dotfiles -s -R ~/devel/Dotfiles --force

    cd ~/devel/Dotfiles
    git submodule init && git submodule update



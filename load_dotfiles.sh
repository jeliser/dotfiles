#!/bin/bash
dotfiles -s -R `pwd`/dotfiles --force
mv ~/.gitconfig.public ~/.gitconfig

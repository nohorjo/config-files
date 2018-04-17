#!/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git submodule add git@github.com:dracula/vim.git ~/.vim/bundle/dracula-theme

#!/bin/bash

ln -s $(pwd)/vimrc ~/.vimrc

mkdir -p \
    ~/.vim/autoload \
    ~/.vim/bundle \
    ~/.vim/colors \
    ~/.vim/ftplugin \
    ~/.vim/plugin \
    ~/.vim/tmp

for f in \
    colors/* \
    filetype.vim \
    ftplugin/* \
    plugin/*
do
    ln -s $(pwd)/${f} ~/.vim/${f}
done

rm ~/.vim/plugin/Session.vim

pushd ~/.vim
curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd bundle
for repo in \
    easymotion/vim-easymotion \
    plasticboy/vim-markdown \
    scrooloose/nerdcommenter \
    scrooloose/nerdtree \
    tpope/vim-sleuth
do
    git clone https://github.com/${repo}.git || cd ${repo#*/} && git pull; cd ..
done

git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

popd


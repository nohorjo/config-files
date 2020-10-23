#!/bin/bash

command -v npm || { echo Please install node; exit 1; }

if command -v apt
then
    apt install build-essential cmake python3-dev mono-runtime golang-go
elif command -v pacman
then
    pacman -S cmake mono go
fi

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
    leafgarland/typescript-vim \
    maksimr/vim-jsbeautify \
    mhinz/vim-startify \
    mxw/vim-jsx \
    pangloss/vim-javascript \
    plasticboy/vim-markdown \
    scrooloose/nerdcommenter \
    scrooloose/nerdtree \
    sirtaj/vim-openscad \
    tpope/vim-sleuth \
    valloric/MatchTagAlways \
    peitalin/vim-jsx-typescript \
    ycm-core/YouCompleteMe
do
    git clone https://github.com/${repo}.git || cd ${repo#*/} && git pull; cd ..
done

cd vim-jsbeautify && git submodule update --init --recursive ; cd ..
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
cd YouCompleteMe && git submodule update --init --recursive && python3 install.py --all; cd ..

rm -rf vim-jsx-typescript/after/indent

popd

npm install -g \
    babel-eslint \
    eslint \
    eslint-config-react-app \
    eslint-plugin-flowtype \
    eslint-plugin-import \
    eslint-plugin-jsx-a11y \
    eslint-plugin-react
npm install -g js-beautify
npm install -g \
    typescript


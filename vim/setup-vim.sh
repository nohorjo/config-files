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
    leafgarland/typescript-vim \
    maksimr/vim-jsbeautify \
    mxw/vim-jsx \
    pangloss/vim-javascript \
    plasticboy/vim-markdown \
    scrooloose/nerdcommenter \
    scrooloose/nerdtree \
    sirtaj/vim-openscad \
    tpope/vim-sleuth \
    valloric/MatchTagAlways \
    ianks/vim-tsx
do
    git clone https://github.com/${repo}.git
done

cd vim-jsbeautify && git submodule update --init --recursive ; cd ..
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git

rm -rf vim-tsx/after/indent

popd

npm install -g \
    babel-eslint \
    eslint \
    eslint-config-react-app \
    eslint-plugin-flowtype \
    eslint-plugin-import \
    eslint-plugin-import \
    eslint-plugin-jsx-a11y \
    eslint-plugin-react
npm install -g js-beautify
npm install -g \
    tslint \
    typescript


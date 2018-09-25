#!/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors

pushd ~/.vim
curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -LSso colors/khaki.vim https://github.com/vim-scripts/khaki.vim/raw/master/colors/khaki.vim
curl -LSso colors/hydrangea.vim https://github.com/yuttie/hydrangea-vim/raw/master/colors/hydrangea.vim

npm install -g \
        jshint \
        tslint \
        typescript \
        js-beautify

cd bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/maksimr/vim-jsbeautify.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/mxw/vim-jsx.git
cd vim-jsbeautify && git submodule update --init --recursive ; cd ..

popd


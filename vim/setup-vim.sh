#!/bin/bash

ln -s $(pwd)/vimrc ~/.vimrc

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors ~/.vim/ftplugin ~/.vim/plugin

cp colours/*.vim ~/.vim/colors/
cp ftplugin/*.vim ~/.vim/ftplugin/
cp plugin/*.vim ~/.vim/plugin/
cp filetype.vim ~/.vim/

pushd ~/.vim
curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/maksimr/vim-jsbeautify.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/mxw/vim-jsx.git
git clone https://github.com/easymotion/vim-easymotion.git
git clone https://github.com/plasticboy/vim-markdown.git
git clone https://github.com/leafgarland/typescript-vim.git
cd vim-jsbeautify && git submodule update --init --recursive ; cd ..

popd

npm install -g eslint babel-eslint
npm install -g typescript
npm install -g tslint
npm install -g js-beautify


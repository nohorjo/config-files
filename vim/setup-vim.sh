#!/bin/bash

ln -s $(pwd)/vimrc ~/.vimrc

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors ~/.vim/ftplugin ~/.vim/plugin ~/.vim/tmp

for f in \
    colors/* \
    ftplugin/* \
    plugin/* \
    filetype.vim
do
    ln -s $(pwd)/${f} ~/.vim/${f}
done

rm ~/.vim/plugin/Session.vim

pushd ~/.vim
curl -LSso autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd bundle
for repo in \
    scrooloose/nerdtree \
    scrooloose/nerdcommenter \
    maksimr/vim-jsbeautify \
    pangloss/vim-javascript \
    mxw/vim-jsx \
    easymotion/vim-easymotion \
    plasticboy/vim-markdown \
    leafgarland/typescript-vim \
    sirtaj/vim-openscad \
    valloric/MatchTagAlways
do
    git clone https://github.com/${repo}.git
done

git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
cd vim-jsbeautify && git submodule update --init --recursive ; cd ..

popd

npm install -g eslint babel-eslint eslint-config-react-app eslint-plugin-import eslint-plugin-flowtype eslint-plugin-jsx-a11y eslint-plugin-react eslint-plugin-import
npm install -g typescript
npm install -g tslint
npm install -g js-beautify


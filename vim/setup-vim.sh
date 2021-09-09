#!/bin/bash

./setup-lite.sh

command -v npm || { echo Please install node; exit 1; }

if command -v apt
then
    apt install build-essential cmake python3-dev mono-runtime golang-go
elif command -v pacman
then
    pacman -S cmake mono go
fi

pushd ~/.vim

cd bundle
for repo in \
    kshenoy/vim-signature \
    leafgarland/typescript-vim \
    maksimr/vim-jsbeautify \
    mxw/vim-jsx \
    pangloss/vim-javascript \
    sirtaj/vim-openscad \
    valloric/MatchTagAlways \
    peitalin/vim-jsx-typescript \
    ycm-core/YouCompleteMe
do
    git clone https://github.com/${repo}.git || cd ${repo#*/} && (git pull; cd ..)
done

cd vim-jsbeautify && git submodule update --init --recursive ; cd ..
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


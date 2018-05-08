#!/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors

curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -LSso ~/.vim/colors/khaki.vim https://github.com/vim-scripts/khaki.vim/raw/master/colors/khaki.vim
curl -LSso ~/.vim/colors/SerialExperimentsLain.vim https://github.com/lu-ren/SerialExperimentsLain/raw/master/colors/SerialExperimentsLain.vim
curl -LSso ~/.vim/colors/desertEx.vim https://github.com/vim-scripts/desertEx/raw/master/colors/desertEx.vim
curl -LSso ~/.vim/colors/hydrangea.vim https://github.com/yuttie/hydrangea-vim/raw/master/colors/hydrangea.vim

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter

echo "autocmd BufNewFile,BufRead *.ts setf typescript" > ~/.vim/filetype.vim
echo "autocmd BufNewFile,BufRead *.ts set syntax=javascript" >> ~/.vim/filetype.vim

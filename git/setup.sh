#!/bin/bash

rm ~/.gitconfig ~/.gitconfig_platform ~/.gitconfig_type

ln -s $(pwd)/gitconfig ~/.gitconfig
./gen-aliases.py git-aliases.sh ~/.gitconfig_aliases

case "$(uname -s)" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
esac
ln -s $(pwd)/gitconfig_$machine ~/.gitconfig_platform
./gen-aliases.py git-aliases_$machine.sh ~/.gitconfig_aliases_platform


echo Type?
select type in personal work
do
    ln -s $(pwd)/gitconfig_$type ~/.gitconfig_type
    ./gen-aliases.py git-aliases_$type.sh ~/.gitconfig_aliases_type
    break
done

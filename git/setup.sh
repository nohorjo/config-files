#!/bin/bash

rm ~/.gitconfig ~/.gitconfig_platform ~/.gitconfig_type

ln -s $(pwd)/gitconfig ~/.gitconfig

case "$(uname -s)" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
esac
ln -s $(pwd)/gitconfig_$machine ~/.gitconfig_platform


echo Type?
select type in personal work
do
    ln -s $(pwd)/gitconfig_$type ~/.gitconfig_type
    break
done

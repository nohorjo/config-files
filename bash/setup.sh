#!/bin/bash

ln -s $(pwd)/bashrc ~/.bashrc_custom

touch ~/.bashrc
if ! grep -q "source ~/.bashrc_custom" ~/.bashrc; then
    echo 'source ~/.bashrc_custom' >> ~/.bashrc
fi

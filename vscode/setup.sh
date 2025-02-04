#!/bin/bash

rm -rf ~/.config/Code\ -\ OSS/User/settings.json \
	~/.config/Code/User/settings.json \
	~/.config/VSCodium/User/settings.json

ln -s $(pwd)/settings.json ~/.config/Code\ -\ OSS/User/settings.json
ln -s $(pwd)/settings.json ~/.config/Code/User/settings.json
ln -s $(pwd)/settings.json ~/.config/VSCodium/User/settings.json


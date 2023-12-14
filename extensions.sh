#!/bin/bash

sudo pacman -Syu jq

let i = ( https://extensions.gnome.org/extension/19/user-themes/ )

EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')
wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
gnome-extensions install --force ${EXTENSION_ID}.zip
if ! gnome-extensions list | grep --quiet ${EXTENSION_ID}; then
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${EXTENSION_ID}
fi
gnome-extensions enable ${EXTENSION_ID}
rm ${EXTENSION_ID}.zip


#!/bin/bash
zip=$1
dest=${2:-.}
temp=$(mktemp -d) && unzip -d "$temp" "$zip" && mkdir -p "$dest" &&
shopt -s dotglob && f=("$temp"/*) &&
if (( ${#f[@]} == 1 )) && [[ -d "${f[0]}" ]] ; then
    mv "$temp"/*/* "$dest"
else
    mv "$temp"/* "$dest"
fi && rmdir "$temp"/* "$temp"

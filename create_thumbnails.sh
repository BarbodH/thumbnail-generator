#! /usr/bin/env bash

# param $1: image name
# param $2: image extension
# param $3: thumbnail dimension size
function create_thumbnail {
	declare -i dim
	dim=$3
	convert "${name}.${extension}" -resize ${dim}x${dim} ".thumbnail/${name}-${dim}.${extension}"
}

declare -i height
declare -i width
declare -i max_dim

height=$(identify -format '%h' $1)
width=$(identify -format '%w' $1)

# determine maximum dimension length
if [ "$height" -gt "$width" ]; then
	max_dim=$height
else
	max_dim=$width
fi

# navigate to the given image's directory
filename=$(basename -- "$1")
name="${filename%.*}"
extension="${filename##*.}"
cd $(dirname $1)
if [ ! -d ".thumbnail" ]; then
	mkdir .thumbnail
fi

# create thumbnails based on maximum dimension size
if [ "$max_dim" -gt 128 ]; then
	create_thumbnail $name $extension 128
fi

if [ "$max_dim" -gt 256 ]; then
	create_thumbnail $name $extension 256
fi

if [ "$max_dim" -gt 512 ]; then
	create_thumbnail $name $extension 512
fi

#! /usr/bin/env bash

# param $1: image
# param #2: thumbnail dimension size
function create_thumbnail {
	declare -i dim
	dim=$2
	fullname=$(basename -- "$1")
	name="${fullname%.*}"
	extension="${fullname##*.}"
	convert "$1" -resize ${dim}x${dim} "$(dirname "$1")/.thumbs/${name}-${dim}.${extension}"
}

DIR=${1:-"./"}

if ! [ -d $DIR ] ; then
    echo $1 is not a directory. >&2
    exit 1
fi

if ! [[ -r $DIR && -x $DIR ]] ; then
    echo $1 is not readable or executable. >&2
    exit 1
fi

find $DIR -iregex ".*\.\(jpg\|jpeg\|png\|tif\|tiff\|bmp\|gif\)$" | grep -v ".thumbs" | grep -v ".metadata" | \
while read image; do 
	declare -i height
	declare -i width
	declare -i max_dim

	height=$(identify -format '%h' "$image")
	width=$(identify -format '%w' "$image")

	# determine maximum dimension length
	if [ "$height" -gt "$width" ]; then
		max_dim=$height
	else
		max_dim=$width
	fi

	# create .thumbnail folder if necessary
	if [ ! -d "$(dirname "$image")/.thumbs" ]; then
		mkdir "$(dirname $image)/.thumbs"
	fi

	if [ ! -d "$(dirname "$image")/.metadata" ]; then
		mkdir "$(dirname "$image")/.metadata"
	fi
	
	# create thumbnails based on maximum dimension size
	if [ "$max_dim" -gt 128 ]; then
		create_thumbnail "$image" 128
	fi

	if [ "$max_dim" -gt 256 ]; then
		create_thumbnail "$image" 256
	fi

	if [ "$max_dim" -gt 512 ]; then
		create_thumbnail "$image" 512
	fi

	# create metadata text file
	identify -verbose "$image" >> "$(dirname "$image")/.metadata/$(basename -- "$image").txt"
done

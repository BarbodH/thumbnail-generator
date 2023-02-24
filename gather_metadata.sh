#! /usr/bin/env bash

DIR=${1:-./}

if ! cd $DIR ; then
    echo $1 is not a directory. >&2
    exit 1
fi

if ! [[ -r $DIR && -x $DIR ]] ; then
    echo $1 is not readable or executable. >&2
    exit 1
fi

find $DIR -iregex ".*\.\(jpg\|jpeg\|png\|tif\|tiff\|bmp\|gif\)$" | grep -v ".thumbs" | \
while read IMAGE ; do 
    mkdir $IMAGE../.thumbs
    mkdir $IMAGE../.metadata

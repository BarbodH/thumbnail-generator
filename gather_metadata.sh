#! /usr/bin/env bash

${1:-"./"}

if cd $1 ; then
    echo $1 is not a directory. >&2
fi

if [ ! [ -r $1 || -x $1 ] ] ; then
    echo $1 is not readable or executable. >&2
fi
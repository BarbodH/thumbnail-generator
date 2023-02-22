#! /usr/bin/env bash

${1:-"./"}

if cd $1 ; then
    echo $1 is not a directory. >&2
fi
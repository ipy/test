#!/bin/bash

DIR=$(dirname $(dirname $(readlink -f $0)))
rm -fr $DIR/dist
git clone --branch=gh-pages --depth=1 git@github.com:ipy/test.git $DIR/dist
rm -fr $DIR/dist/*
cp -r $DIR/src/* $DIR/dist
VERSION=`curl -is "https://github.com/chiflix/splayerx/releases/latest" | grep -E '^Location: ' | grep -oE "([0-9]+.)+[0-9]"`
echo "The latest version is: $VERSION"
cat $DIR/src/index.html | sed "s/{{version}}/$VERSION/g" > $DIR/dist/index.html

cd $DIR/dist
git add -A
git commit -m "`date`"
git push

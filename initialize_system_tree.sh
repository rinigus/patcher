#!/bin/bash

S=system

rm -rf $S
mkdir $S

(cd $1 && find . -type d -print0 | xargs -0 tar c --no-recursion ) | tar xv -C $S --numeric-owner 

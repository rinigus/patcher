#!/bin/bash

ZDIR=zip
ZFILE=update.android.zip

SDIR=system
TFILE=update-system.tar.bz2

rm -f $TFILE
sudo tar cvfj $TFILE system
mv $TFILE $ZDIR

cd zip
rm -f $ZFILE
zip -r $ZFILE META-INF $TFILE updater-unpack.sh

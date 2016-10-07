#!/bin/bash

ZDIR=zip
ZFILE=update.android.zip

SDIR=system
TFILE=update-system.tar.gz

rm -f $TFILE
sudo tar cvfz $TFILE system
mv $TFILE $ZDIR

cd zip
rm -f $ZFILE
zip -r $ZFILE META-INF $TFILE updater-unpack.sh

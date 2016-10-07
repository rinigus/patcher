#! /sbin/sh

FS_ARC="/tmp/update-system.tar.bz2"
FS_DST="/system"

tar --numeric-owner -xvjf $FS_ARC -C $FS_DST
EXIT=$?

rm $FS_ARC

exit $EXIT

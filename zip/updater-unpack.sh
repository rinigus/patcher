#!/sbin/sh

FS_ARC="/tmp/update-system.tar.gz"
FS_DST="/system"

tar --numeric-owner -xvzf $FS_ARC -C $FS_DST
EXIT=$?

rm $FS_ARC

exit $EXIT

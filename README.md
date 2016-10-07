# patcher
Scripts to find the difference between system partition in two Android ZIP files

NB! This is work in progress!

## Aim

These scripts are tailored for building a flashable ZIP that allows
you to update Android system partition from VERSION_OLD to
VERSION_NEW.

To generate such flashable ZIP, two installation flashable ZIPs with
different Android versions should be given.

## Requirements

* python with numpy installed
* python3 for sdat2img
* Linux with sudo access


## Workflow

NB! All scripts should be executed from the directory with the
scripts. Android ZIPs can be somewhere else in the system.

* Download two Android ZIPs. In this example we will use
  cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip and
  cm-12.1-20160928-UNOFFICIAL-mako.zip.

* Extract and mount system partition via mount-loop. For that, use
  uncompress-android-zip.sh script. Note that this script will run
  sudo to mount extracted image in the end of it:

  * `./uncompress-android-zip.sh cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip`
  * `./uncompress-android-zip.sh cm-12.1-20160928-UNOFFICIAL-mako.zip`

  This would result in system partitions visible under
  
  * cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip-uncompressed/system-sf
  * cm-12.1-20160928-UNOFFICIAL-mako.zip-uncompressed/system-fs

  (note that its system-fs to avoid clashes with possible system
  folder in Android ZIP).

* Find and copy the files that are different between two system
  images. Since you want to preserve UID/GID, you have to run the
  script doing it as sudo:

  * `sudo python patcher.py cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip-uncompressed/system-fs cm-12.1-20160928-UNOFFICIAL-mako.zip-uncompressed/system-fs system`

  The arguments are: <OLD_VERSION_SYSTEMFS> <NEW_VERSION_SYSTEMFS> system

  with the last one being the folder that would contain the
  difference. Keep it as "system" to use the next script.

* **Verify that zip/META-INF/com/google/android/updater-script
  corresponds to your device!** Right now, its made for Nexus 4 with
  corresponding binary blob
  zip/META-INF/com/google/android/update-binary. Take a look on your
  device Sailfish image to get 

  * zip/META-INF/com/google/android/update-binary may need to be replaced
    with the one from your device (different architecture, for example)

  * Line with assert in zip/META-INF/com/google/android/updater-script
    has to be updated

  * IMPORTANT! Update line with mount. Right now its

    * mount("ext4", "EMMC", "/dev/block/platform/msm_sdcc.1/by-name/system", "/system");

    See what are yours mount options (you could check corresponding
    scripts for CM and SFOS).


* Make flashable ZIP by running

  * `./makezip.sh`

  You (maybe) will be asked for sudo password again to make get all
  files in system (permissions of some files).

  Flashable ZIP should be under "zip" subfolder under name update.android.zip

* Cleanup:

  * unmount loop filesystems:
    * `sudo umount cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip-uncompressed/system-fs`
    * `sudo umount cm-12.1-20160928-UNOFFICIAL-mako.zip-uncompressed/system-fs`

  * Delete temp files/folders:
    * `sudo rm -rf system`
    * `rm -rf cm-12.1-20151007-SNAPSHOT-YOG4PAO334-mako.zip-uncompressed`
    * `rm -rf cm-12.1-20160928-UNOFFICIAL-mako.zip-uncompressed`

 You would have your new update zip and corresponding tar.bz2 in zip
 folder.
  

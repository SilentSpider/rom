#!/bin/bash
#
# Building an android update ROM
#

echo "Building ROM"
rm -f update.zip

# Build boot animation
cd bootanimation
7z a -tzip -mx=0 ../bootanimation.zip -r *
cd ..
mv bootanimation.zip src/common

# Build initial boot logo
cd bootlogo
python aml-imgpack.py --pack logo.img bootup.bmp upgrade_error.bmp upgrade_fail.bmp upgrade_logo.bmp upgrade_success.bmp upgrade_unfocus.bmp upgrade_upgrading.bmp
cd ..
mv bootlogo/logo.img src/common 

# Add TOR artifacts
rm -fr src/common/tor
mkdir src/common/tor
cp build/built/* src/common/tor

# Add Chat artifacts
rm -fr src/common/chat
mkdir src/common/chat
cp busybox jx server.tar.gz src/common/chat

# Add Silent Spider OS
cp app/build/outputs/apk/app-debug.apk src/common/com.silentspider.os.apk

# Build new ram disk
cd ramdisk
chmod a+x mkbootimg
perl split_bootimg.pl boot-ref.img
rm -fr ramdisk
mkdir ramdisk
cd ramdisk
gzip -dc ../boot-ref.img-ramdisk.gz | cpio -i
cat ../init.rc > init.rc
cd ..
perl repack-bootimg.pl boot-ref.img-kernel ramdisk boot.img
cd ..
cp ramdisk/boot.img src/common

# Copy new build.prop
cp ramdisk/build.prop src/common

# Build OTA zip
cd src
7z a -tzip ../update.zip -r *

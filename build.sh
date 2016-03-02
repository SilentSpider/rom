#!/bin/bash
#
# Building an android update ROM
#

echo "Building ROM"
rm -f update.zip

cd bootanimation
7z a -tzip -mx=0 ../bootanimation.zip -r *
cd ..
mv bootanimation.zip src/common

cd bootlogo
python aml-imgpack.py --pack logo.img bootup.bmp upgrade_error.bmp upgrade_fail.bmp upgrade_logo.bmp upgrade_success.bmp upgrade_unfocus.bmp upgrade_upgrading.bmp
cd ..
mv bootlogo/logo.img src/common 

cd src
7z a -tzip ../update.zip -r *

#!/bin/bash
#
# Building an android update ROM
#

echo "Building ROM"
rm -f update.zip

cd bootanimation
7z a ../bootanimation.zip -r *
cd ..
mv bootanimation.zip src/common

cd src
7z a ../update.zip -r *

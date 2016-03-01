#!/bin/bash
#
# Building an android update ROM
#

echo "Building ROM"
rm -f update.zip

7z a -tzip bootanimation.zip -r bootanimation/*
mv bootanimation.zip src/common

7z a -tzip update.zip -r src/*

#!/bin/bash
#
# Building an android update ROM
#

echo "Building ROM"

jar cvf bootanimation.zip -C bootanimation/ .
mv bootanimation.zip src/common

jar cvf update.zip -C src/ .
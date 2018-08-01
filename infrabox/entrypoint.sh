#!/bin/bash -e


echo "##Preparing Compile"

cp ./.config.k3 ./.config

./compile.sh

echo "##compile finished"

cp bin/targets/*/*/openwrt* /infrabox/archive/

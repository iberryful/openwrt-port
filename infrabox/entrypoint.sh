#!/bin/bash -e 

mkdir -p build_dir
for f in `ls /infrabox/cache/`; do
	cp -Rf /infrabox/cache/$f build_dir/
	echo "Got cache" $f
done
echo "##Preparing Compile"

cp ./.config.k3 ./.config

./compile.sh

echo "##compile finished"

echo "archive fireware"
cp bin/targets/*/*/openwrt* /infrabox/upload/archive/

echo "cache tools"
cp -Rf build_dir/host /infrabox/cache/


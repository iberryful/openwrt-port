#!/bin/bash -e 

mkdir -p build_dir
for f in `ls /infrabox/cache/`; do
	cp -Rf /infrabox/cache/$f build_dir/
	echo "Got cache" $f
done
echo "##Preparing Compile"

if [ -z $TARGET_PROFILE ];then
	echo "##Failed, environment TARGET_PROFILE not set"
	exit 1
fi

cp ./.config.${TARGET_PROFILE}.minial ./.config
cat ./.config.common >> ./.config

echo "##Compiling for $TARGET_PROFILE"

./compile.sh

echo "##compile finished"

echo "archive firmware"
cp bin/targets/*/*/openwrt* /infrabox/upload/archive/

echo "cache tools"
cp -Rf build_dir/host /infrabox/cache/


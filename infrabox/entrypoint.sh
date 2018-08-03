#!/bin/bash -e 

mkdir -p build_dir
for f in `ls /infrabox/cache/`; do
	tar -zxf /infrabox/cache/$f -C ./ 
	#cp -Rf /infrabox/cache/$f build_dir/
	echo "Got cache" $f
done
echo "##Preparing Compile"

if [ -z $TARGET_PROFILE ];then
	echo "##Failed, environment TARGET_PROFILE not set"
	exit 1
fi

echo "##Install ccache"
git clone https://github.com/ccache/ccache.git /tmp/ccache 
pushd /tmp/ccache 
git checkout v3.4.2 
./autogen.sh 
./configure 
make && make install && popd && rm -rf /tmp/ccache


#mkdir -p infrabox/cache/ccache
#export CCACHE_DIR=infrabox/cache/ccache
#ccache -M 2G

cp ./.config.${TARGET_PROFILE}.minial ./.config
cat ./.config.common >> ./.config


echo "##Compiling for $TARGET_PROFILE"

./compile.sh

echo "##compile finished"

echo "archive firmware"
cp bin/targets/*/*/openwrt* /infrabox/upload/archive/

echo "cache staging_dir"
#cp -Rf build_dir/host /infrabox/cache/
tar -zcf /infrabox/cache/staging_dir.tar.gz staging_dir


#!/bin/bash 

git submodule update --recursive
./scripts/feeds update -a
./scripts/feeds install -a

pushd package/add-on/luci-app-shadowsocks/tools/po2lmo
make && make install
popd

echo "Downloading packages"

make download

echo "##Drop file cache"
echo 3 > /proc/sys/vm/drop_caches

echo "##set ccache"

export CONFIG_CCACHE=y
#ccache -s

echo "##Start compile, try make -j first"

make -j3 

if [ $? -ne 0 ]; then
        echo "##Parallel Compile failed, try make -j1"
        make -j1 
fi

if [ $? -ne 0 ]; then
	echo "##Compile failed, show detailed messages"
	make -j1 V=s 
fi

#echo "##show ccache stats"
#ccache -s

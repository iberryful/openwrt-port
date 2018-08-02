#!/bin/bash 

git submodule update --recursive
./scripts/feeds update -a
./scripts/feeds install -a

pushd package/add-on/luci-app-shadowsocks/tools/po2lmo
make && make install
popd

echo "##Start compile, try make -j"

make -j 

if [ $? -ne 0 ]; then
        echo "##Parallel Compile failed, try make -j1"
        make -j1 
fi

if [ $? -ne 0 ]; then
	echo "##Compile failed, show detailed messages"
	make -j1 V=s 
fi

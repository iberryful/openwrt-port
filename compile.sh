#!/bin/bash 

git submodule update --recursive
./scripts/feeds update -a
./scripts/feeds install -a

pushd package/add-on/luci-app-shadowsocks/tools/po2lmo
make && make install
popd

echo "##Start compile"

make -j1 -vadlf 

if [ $? -ne 0 ]; then
	echo "##Compile failed, show detailed messages"
	make -j1 V=s
fi


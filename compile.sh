#!/bin/bash -e

git submodule update --recursive
./scripts/feeds update -a
./scripts/feeds install -a

pushd package/add-on/luci-app-shadowsocks/tools/po2lmo
make && make install
popd

make -j1 

if [ $? -ne 0 ]; then
	make -j1 V=s
fi


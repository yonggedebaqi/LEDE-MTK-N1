#!/bin/bash
cd "$(dirname $0)";

zerotier-cli join 6ab565387a78c994

sleep 5 && export all_proxy=socks5://192.168.192.175:2080
#sleep 5 && export all_proxy=socks5://192.168.192.117:4188

sleep 5 && export GO111MODULE=on

sleep 5 && export GOPROXY=https://goproxy.io

sleep 5 && git clone https://github.com/coolsnowwolf/lede

sleep 5 && cd lede/

sleep 5 && ./scripts/feeds update -a && ./scripts/feeds install -a

sleep 5 && cp Rf /home/openwrt/lede_bak/* /home/openwrt/lede/

sleep 5 && git pull && ./scripts/feeds update packages && ./scripts/feeds install -a -p packages

make -j1 download

sed -i 's/bootstrap/material/g' feeds/luci/collections/luci/Makefile
sed -i 's# (default)##g' feeds/luci/themes/luci-theme-bootstrap/Makefile
sed -i 's#Material Theme#Material Theme (default)#g' feeds/luci/themes/luci-theme-material/Makefile
sed -i 's#Bootstrap Theme (default)#Bootstrap#g' feeds/luci.index
sed -i 's#Material Theme#Material Theme (default)#g' feeds/luci.index
sed -i 's#bootstrap#material#g' feeds/luci/modules/luci-base/root/etc/config/luci
sed -i 's#+luci-theme-bootstrap#+luci-theme-material#g' feeds/luci.index
sed -i 's#Bootstrap#Material#g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's#bootstrap#material#g' feeds/luci/collections/luci-nginx/Makefile
sed -i 's#bootstrap#material#g' feeds/luci/collections/luci-ssl-nginx/Makefile
sed -i 's/Bootstrap/Material/g' feeds/luci/collections/luci/Makefile
sed -i 's/12345678/sammi100200/g' package/lean/mt/luci-app-mtwifi/luasrc/controller/mtkwifi.lua

make -j1 V=s



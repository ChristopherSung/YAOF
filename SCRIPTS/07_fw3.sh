#!/bin/bash
# 滚回fw3
sed -i 's,iptables-nft,iptables-legacy,g' ./package/new/luci-app-passwall2/Makefile
sed -i 's,iptables-nft,iptables-legacy,g' ./package/new/luci-app-passwall2/Makefile
sed -i 's,iptables-nft +kmod-nft-fullcone,iptables-mod-fullconenat,g' ./package/lean/lean-translate/Makefile
rm -rf ./feeds/packages/net/miniupnpd
svn export https://github.com/coolsnowwolf/packages/trunk/net/miniupnpd feeds/packages/net/miniupnpd
rm -rf ./feeds/luci/applications/luci-app-upnp
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-upnp feeds/luci/applications/luci-app-upnp
sed -i '/firewall/d' ./.config
sed -i '/offload/d' ./.config
sed -i '/tables/d' ./.config
sed -i '/nft/d' ./.config
echo '
CONFIG_PACKAGE_firewall=y
# CONFIG_PACKAGE_firewall4 is not set
' >>./.config
rm -rf ./feeds/luci/applications/luci-app-zerotier
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-zerotier feeds/luci/applications/luci-app-zerotier
wget -P feeds/luci/applications/luci-app-zerotier/ https://github.com/QiuSimons/OpenWrt-Add/raw/master/move_2_services.sh
chmod -R 755 ./feeds/luci/applications/luci-app-zerotier/move_2_services.sh
pushd feeds/luci/applications/luci-app-zerotier
bash move_2_services.sh
popd
ln -sf ../../../feeds/luci/applications/luci-app-zerotier ./package/feeds/luci/luci-app-zerotier

exit 0
# 设置默认IP地址
# sed -i 's/192.168.100.1/10.0.0.3/g' package/istoreos-files/Makefile
# sed -i 's/192.168.1.1/10.0.0.3/g' package/base-files/files/bin/config_generate


# 清除登陆密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' package/lean/default-settings/files/zzz-default-settings

# drop mosdns and v2ray-geodata packages that come with the source
find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
find ./ | grep Makefile | grep mosdns | xargs rm -f

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 允许WAN口访问Luci Web界面
sed -i 's/option rfc1918_filter.*/option rfc1918_filter '\''0'\''/' package/network/services/uhttpd/files/uhttpd.config
echo "/etc/init.d/uhttpd restart" >> package/base-files/files/etc/rc.local


# 调整 Docker 到 服务 菜单
# sed -i 's/"admin"/"admin", "services"/g' feeds/luci/applications/luci-app-dockerman/luasrc/controller/*.lua
# sed -i 's/"admin"/"admin", "services"/g; s/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/model/cbi/dockerman/*.lua
# sed -i 's/admin\//admin\/services\//g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/*.htm
# sed -i 's|admin\\|admin\\/services\\|g' feeds/luci/applications/luci-app-dockerman/luasrc/view/dockerman/container.htm

./scripts/feeds update -a
./scripts/feeds install -a

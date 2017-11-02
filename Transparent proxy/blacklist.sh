#!/bin/sh
# Compile:by-wpyok500    2017-11-01
# 下载创建ipset  gfwlist黑名单

echo -e "\e[1;36m 下载创建ipset   gfwlist黑名单规则 \e[0m\n"
wget --no-check-certificate -t 30 -T 80 "https://raw.githubusercontent.com/cokebar/gfwlist2dnsmasq/master/gfwlist2dnsmasq.sh" -O gfw2dnsmasq
sh gfw2dnsmasq -o gfwlist.conf -s gfwlist
#复制到dnsmasq的配置目录
cp gfwlist.conf /etc/storage/dnsmasq/dnsmasq.d/
#删除临时gfwlist.conf
rm -f gfwlist.conf

#创建gfwlist黑名单
ipset create gfwlist hash:ip maxelem 65536

#使用iptables做相应的规则转发到V2ray 的10086端口
iptables -t nat -A PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 10086
iptables -t nat -A OUTPUT -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 10086
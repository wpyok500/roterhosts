#!/bin/sh
# Compile:by-wpyok500    2017-11-01
# 下载创建ipset中国白名单

echo -e "\e[1;36m 下载中国白名单 \e[0m\n"

wget --no-check-certificate -t 30 -T 80 -O- "http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest" \
|grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt

#创建chnroute白名单
ipset create chnroute hash:net maxelem 65536
#将白名单转化为ipset集合
for ip in $(cat 'chnroute.txt'); do
   ipset add chnroute $ip
done
#删除临时白名单
rm -f chnroute.txt

#使用iptables做相应的规则转发到V2ray 的10086端口
iptables -t nat -A PREROUTING -p udp --dport 53 -j RETURN
iptables -t nat -A PREROUTING -p tcp -m set ! --match-set chnroute dst -j REDIRECT --to-port 10086
iptables -t nat -A OUTPUT -p udp --dport 53 -j RETURN
iptables -t nat -A OUTPUT -p tcp -d  Your proxy IP address -j RETURN
iptables -t nat -A OUTPUT -p tcp -m set ! --match-set chnroute dst -j REDIRECT --to-port 10086
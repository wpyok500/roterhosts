路由器器透明代理使用脚本，3种方式

1、gfw黑名单模式：blacklist.sh

curl -c - -o hsfq.sh https://raw.githubusercontent.com/wpyok500/roterhosts/master/Transparent%20proxy/curl/blacklist.sh;sh hsfq.sh;rm -f hsfq.sh

2、白名单模式：whitelist.s

curl -c - -o hsfq.sh https://raw.githubusercontent.com/wpyok500/roterhosts/master/Transparent%20proxycurl/whitelist.sh;sh hsfq.sh;rm -f hsfq.sh

3、V2ray本身的透明代理方式：暂时还未搞明白

4、备份iptables ipset规则：backup.sh

5、恢复iptables ipset规则：restore.sh

使用这些方法前，你的路由器必须先安装dnsmasq iptables ipset模块

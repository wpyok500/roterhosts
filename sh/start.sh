#!/bin/sh

#创建文件夹
mkdir -p /etc/storage/dnsmasq/dns/conf
##下载hosts规则
##cd /etc/storage/dnsmasq/dns
##wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/hosts -O hosts
##sed -i -e '/gay\|uvwxyz\|XiaoQiang\|alfredapp\|dxomark/d' -i -e "1 i\## Downloaded：$(date "+%Y-%m-%d %H:%M:%S")" hosts

#下载dnsmasq规则
cd /etc/storage/dnsmasq/dns/conf

##wget --no-check-certificate https://raw.githubusercontent.com/sy618/hosts/master/dnsmasq/dnsfq -O dnsfq;sed -i "1 i\## Downloaded：$(date "+%Y-%m-%d %H:%M:%S")" dnsfq
##wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/ip.conf -O ip.conf;sed -i "1 i\## Downloaded：$(date "+%Y-%m-%d %H:%M:%S")" ip.conf
##wget --no-check-certificate https://raw.githubusercontent.com/vokins/yhosts/master/dnsmasq/union.conf -O union.conf;sed -i "1 i\## Downloaded：$(date "+%Y-%m-%d %H:%M:%S")" union.conf

echo -e "\e[1;36m 下载 Fq 翻网规则 \e[0m\n"
TMP_FQ=/tmp/tmp_fq
TMP_FQ2=/tmp/tmp_fq2
FQ=/tmp/fq

[ -f ${FQ} ] && rm -rf ${FQ};[ -f ${TMP_FQ2} ] && rm -rf ${TMP_FQ2};[ -f ${TMP_FQ} ] && rm -rf ${TMP_FQ}
#wget --no-check-certificate -t 15 -T 50 -O- "https://raw.githubusercontent.com/896660689/OS/master/tumblr" >> ${TMP_FQ2}
wget --no-check-certificate -t 15 -T 50 -O- "https://raw.githubusercontent.com/sy618/hosts/master/dnsmasq/dnsfq" \
|sed -E -e "/# /d" -e "/\#a/d" -e "/^$/d" -e "/★/d" -e "/^#/d" -e "/^$/d" >> ${TMP_FQ2}

wget --no-check-certificate -t 30 -T 80 -O- "https://raw.githubusercontent.com/wangchunming/2017hosts/master/hosts-pc" \
| awk '$1 ~ /^[0-9]/ {printf("address=/%s/%s\n", $2,$1)}' > ${TMP_FQ}
sed -i "/google/d" ${TMP_FQ}
#wget --no-check-certificate -t 30 -T 80 -O- "https://raw.githubusercontent.com/896660689/Hsfq/master/hs_pc" > ${TMP_FQ}

sed -i "/tumblr/d" ${TMP_FQ}

cat ${TMP_FQ} ${TMP_FQ2} > ${FQ}

echo -e "\033[45;37m 翻网规则下载完成 \033[0m\n"
# 删除临时缓存
rm -rf ${TMP_FQ2} ${TMP_FQ} >/dev/null 2>&1

mv /tmp/fq dnsfq.conf
sed -i "1 i## update：$(date "+%Y-%m-%d %H:%M:%S")" dnsfq.conf

#重启dnsmasq
restart_dhcpd



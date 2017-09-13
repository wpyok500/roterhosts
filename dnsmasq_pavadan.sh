#!/bin/sh
# Compile:by-lanse	2017-08-26
route_vlan=`/sbin/ifconfig br0 |grep "inet addr"| cut -f 2 -d ":"|cut -f 1 -d " " `
username=`nvram get http_username`
CRON_FILE=/etc/storage/cron/crontabs/$username
echo
clear
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
echo -e "\e[1;31m--全自动安装脚本--\e[1;36m翻网看世界\e[1;31m--\e[1;36m(padavan)专用\e[1;31m--\e[1;36m自动运行脚本\e[1;31m包含去AD规则\e[0m"
echo "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
echo
echo -e "\e[1;33m >	1. 安装 \e[1;33mpadavan \033[41;37m翻墙去广告脚本\e[0m"
echo
echo -e "\e[1;33m >	2. 更新 \e[1;33mpadavan翻墙去广告脚本\e[0m"
echo
echo -e "\e[1;31m >	3. 卸载 \e[1;33mpadavan翻墙去广告脚本\e[0m"
echo
echo -e "\e[1;36m >	4. 安装 \e[1;362mpadavan \033[41;37m去广告脚本\e[0m"
echo
echo -e "\e[1;36m >	5. 更新 \e[1;36mpadavan去广告脚本\e[0m"
echo
echo -e "\e[1;31m >	6. 卸载 \e[1;36mpadavan去广告脚本\e[0m"
echo
echo -e "\e[1;33m >	7. 安装 \e[1;33mpadavan \033[41;37m翻墙脚本\e[0m"
echo
echo -e "\e[1;33m >	8. 更新 \e[1;33mpadavan翻墙脚本\e[0m"
echo
echo -e "\e[1;31m >	9. \033[41;37m退出\e[0m"
echo
echo -e -n "\e[44;37m 请输入数字继续执行: \e[0m" 
read Function_options
if [ "$Function_options" == "1" ]; then
	echo
	[ -f /tmp/hsfq_script.sh ] && rm -rf /tmp/hsfq_script.sh
	wget --no-check-certificate https://raw.githubusercontent.com/896660689/Hsfq/master/hsfq_script.sh -O \
	/tmp/hsfq_script.sh && chmod +x /tmp/hsfq_script.sh && . /tmp/hsfq_script.sh
	echo
fi
echo
if [ "$Function_options" == "2" ]; then
	sh /etc/storage/dnsmasq.d/hsfq_update.sh
	echo
	echo -e "\e[1;34m 更新已完成,返回主菜单 \e[0m"
	sleep 3
	echo
	sh /tmp/hsfq_install
	echo
fi
echo
if [ "$Function_options" == "3" ]; then
	if [ -f "/etc/storage/dnsmasq/dnsmasq.conf" ]; then
		echo -e "\e[1;31m 开始卸载启动规则 \e[0m"
		sed -i '/127.0.0.1/d' /etc/storage/dnsmasq/dnsmasq.conf
		sed -i '/log/d' /etc/storage/dnsmasq/dnsmasq.conf
		sed -i '/no-hosts/d' /etc/storage/dnsmasq/dnsmasq.conf
		sed -i '/strict-order/d' /etc/storage/dnsmasq/dnsmasq.conf
		sed -i '/1800/d' /etc/storage/dnsmasq/dnsmasq.conf	
		sed -i '/dnsmasq.d/d' /etc/storage/dnsmasq/dnsmasq.conf
	fi

	if [ -d "/etc/storage/dnsmasq.d/hosts" ]; then
		echo -e "\e[1;31m 删除残留文件夹以及配置 \e[0m"
		sleep 2
		rm -rf /etc/storage/dnsmasq.d
	fi

	if [ -f "/etc/storage/cron/crontabs/$username" ]; then
		echo -e "\e[1;31m 删除更新计划任务 \e[0m"
		sleep 2
		sed -i '/fqhs/d' /etc/storage/cron/crontabs/$username
		killall crond;/usr/sbin/crond
	fi

	if [ -f "/etc/storage/post_iptables_script.sh" ]; then
		echo -e "\e[1;31m 删除防火墙规则 \e[0m"
		sleep 2
		sed -i '/DNAT/d' /etc/storage/post_iptables_script.sh
		sed -i '/iptables-save/d' /etc/storage/post_iptables_script.sh
		sed -i '/resolv.conf/d' /etc/storage/post_iptables_script.sh
		sed -i '/restart_dhcpd/d' /etc/storage/post_iptables_script.sh
	fi

	if [ -f "/usr/sbin/dnsmasq" ]; then
		echo -e "\e[1;31m 重启 dnsmasq \e[0m"
		[ -f /tmp/fqhs_an.sh ] && rm -f /tmp/fqhs_an.sh
		restart_dhcpd && /usr/sbin/dnsmasq restart >/dev/null 2>&1
	fi

	echo -e "\e[1;34m-- Hsfq 卸载完毕,返回主菜单--\e[0m" && sleep 3
	sh /tmp/hsfq_install
fi
echo
if [ "$Function_options" == "4" ]; then
	echo
	[ -f /tmp/hsfq_script.sh ] && rm -rf /tmp/hsfq_script.sh
	wget --no-check-certificate https://raw.githubusercontent.com/896660689/Hsfq/master/ss_ad.sh -O \
	/tmp/hsfq_ssad.sh && chmod +x /tmp/hsfq_ssad.sh && . /tmp/hsfq_ssad.sh
	echo
fi
echo
if [ "$Function_options" == "5" ]; then
	echo
	sh /etc/storage/bin/hsfq_ssad.sh
	echo
	echo -e "\e[1;34m 去广告脚本更新已完成,返回主菜单 \e[0m"
	sleep 3
	echo
	sh /tmp/hsfq_install
	echo
fi
echo
if [ "$Function_options" == "6" ]; then
	if [ -f "/etc/storage/dnsmasq/dnsmasq.conf" ]; then
		echo -e "\e[1;31m 开始卸载启动规则 \e[0m"
		sed -i '/addn-hosts/d' /etc/storage/dnsmasq/dnsmasq.conf
		echo
	fi

	if [ -f "/etc/storage/cron/crontabs/$username" ]; then
		echo -e "\e[1;31m 删除更新计划任务 \e[0m"
		sleep 2
		sed -i '/ss_ad.sh/d' /etc/storage/cron/crontabs/$username
		killall crond;/usr/sbin/crond
	fi

	if [ -d "/etc/storage/bin/hosts" ]; then
		echo -e "\e[1;31m 删除残留文件夹以及配置 \e[0m"
		sleep 2
		rm -rf /etc/storage/bin
	fi

	if [ -f "/usr/sbin/dnsmasq" ]; then
		echo -e "\e[1;31m 重启 dnsmasq \e[0m"
		restart_dhcpd && /usr/sbin/dnsmasq restart >/dev/null 2>&1
	fi

	[ -f "/tmp/hsfq_ssad.sh" ] && rm -f /tmp/hsfq_ssad.sh
	echo -e "\e[1;34m--去广告脚本卸载完毕,返回主菜单--\e[0m" && sleep 3
	sh /tmp/hsfq_install
fi
echo
if [ "$Function_options" == "7" ]; then
	echo
	[ -f /tmp/hsfq_script.sh ] && rm -rf /tmp/hsfq_script.sh
	wget --no-check-certificate https://raw.githubusercontent.com/896660689/Hsfq/master/hsfq_script.sh -O \
	/tmp/hsfq_script.sh && chmod +x /tmp/hsfq_script.sh && . /tmp/hsfq_script.sh
	echo
fi
echo
if [ "$Function_options" == "8" ]; then
	sh /etc/storage/dnsmasq.d/hsfq_update.sh
	echo
	echo -e "\e[1;34m 更新已完成,返回主菜单 \e[0m"
	sleep 3
	echo
	sh /tmp/hsfq_install
	echo
fi
echo
if [ "$Function_options" == "9" ]; then
	[ -f /tmp/hsfq_install ] && rm -f /tmp/hsfq_install
	[ -f /tmp/hsfq_script.sh ] && rm -f /tmp/hsfq_script.sh
	echo
fi
echo
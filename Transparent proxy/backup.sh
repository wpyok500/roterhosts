#!/bin/sh
# Compile:by-wpyok500    2017-11-01
# 备份iptables ipset 规则

echo -e "\e[1;36m 开始备份规则 \e[0m\n"

iptables-save > /etc/iptables-backup
ipset-save > /etc/ipset-backup
#!/bin/sh
# Compile:by-wpyok500    2017-11-01
# 恢复iptables ipset 规则

echo -e "\e[1;36m 恢复规则 \e[0m\n"

iptables-restore < /etc/iptables-backup
ipset-restore < /etc/ipset-backup
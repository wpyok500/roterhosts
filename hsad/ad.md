dnsmasq去广告

【手动添加】

1.手动添加到【在 WAN 上行/下行启动后执行】（在自定义脚本里），实现网络连接上时自动更新。也可以直接在命令行里直接运行。

自由上网dnsmasq：

wget --no-check-certificate https://raw.githubusercontent.com/wpyok500/roterhosts/master/hsad/ss_ad.sh -O ss_ad.sh;sh ss_ad.sh

2.手动添加到【定时任务crontab】（在 系统管理→服务→计划任务 (Crontab)里），实现每天定时自动更新。

自由上网dnsmasq：

01 00 * * * wget --no-check-certificate https://raw.githubusercontent.com/wpyok500/roterhosts/master/hsad/ss_ad.sh -O ss_ad.sh;sh ss_ad.sh;rm -f ss_ad.sh


3.删除

wget --no-check-certificate https://raw.githubusercontent.com/wpyok500/roterhosts/master/hsad/del -O del.sh;sh del.sh;rm -f ss_ad.sh

# roterhosts

路由器hosts自动翻网

【手动添加】

1.手动添加到【在 WAN 上行/下行启动后执行】（在自定义脚本里），实现网络连接上时自动更新。也可以直接在命令行里直接运行。

自由上网dnsmasq：

wget --no-check-certificate https://raw.githubusercontent.com/wpyok500/roterhosts/master/hsfq -O hsfq.sh;sh hsfq.sh


2.手动添加到【定时任务crontab】（在 系统管理→服务→计划任务 (Crontab)里），实现每天定时自动更新。

自由上网dnsmasq：


01 00 * * * wget --no-check-certificate https://raw.githubusercontent.com/wpyok500/roterhosts/master/hsfq -O hsfq.sh;sh hsfq.sh



适用padavan小型基本hosts.可以看到更多的网页内容。 *本脚本个人学习代码体验试用，不能用于商用，此为公开源码平台，试用者自负使用相关法律问题。

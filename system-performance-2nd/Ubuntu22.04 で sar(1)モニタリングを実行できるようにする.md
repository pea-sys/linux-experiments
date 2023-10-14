### Ubuntu22.04 で sar(1)モニタリングを実行できるようにする

ツールをインストール後、設定ファイルを変更する。

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo apt install sysstat
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
・・・
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sar
Cannot open /var/log/sysstat/sa30: No such file or directory
Please check if data collecting is enabled
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo vi /etc/default/sysstat
```

sysstat の中身を編集

```
#
# Default settings for /etc/init.d/sysstat, /etc/cron.d/sysstat
# and /etc/cron.daily/sysstat files
#

# Should sadc collect system activity informations? Valid values
# are "true" and "false". Please do not put other values, they
# will be overwritten by debconf!
ENABLED="true"
```

スケジュールは cron タブから変更可能

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sudo service sysstat restart
masami@DESKTOP-L18OTEK:/$ cat /etc/cron.d/sysstat
# The first element of the path is a directory where the debian-sa1
# script is located
PATH=/usr/lib/sysstat:/usr/sbin:/usr/sbin:/usr/bin:/sbin:/bin

# Activity reports every 10 minutes everyday
5-55/10 * * * * root command -v debian-sa1 > /dev/null && debian-sa1 1 1

# Additional run at 23:59 to rotate the statistics file
59 23 * * * root command -v debian-sa1 > /dev/null && debian-sa1 60 2
```

動作確認

```
masami@DESKTOP-L18OTEK:/mnt/c/Windows/system32$ sar -n TCP 1 5
Linux 5.15.90.1-microsoft-standard-WSL2 (DESKTOP-L18OTEK)       09/30/23        _x86_64_        (4 CPU)

13:35:36     active/s passive/s    iseg/s    oseg/s
13:35:37         0.00      0.00      0.00      0.00
13:35:38         0.00      0.00      0.00      0.00
13:35:39         0.00      0.00      0.00      0.00
13:35:40         0.00      0.00      0.00      0.00
13:35:41         0.00      0.00      0.00      0.00
Average:         0.00      0.00      0.00      0.00
```

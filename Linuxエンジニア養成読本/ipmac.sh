#!/bin/sh

#初期設定
NETWORK="192.168.1"
BEGIN="33"
END="46"

#同一セグメント内の全IPアドレスにpingを実行し、ARP情報を収集
for i in `seq $BEGIN 1 $END` ; do
        ping -c 1 -w 1$NETWORK.$i > /dev/null 2>&1
        echo -ne "\r$NETWORK.$iを調査中..."
done

#ARPテーブルを表示
echo -e "\r調査結果-----------------------------------------------"
/sbin/arp -n | grep ether

exit 0
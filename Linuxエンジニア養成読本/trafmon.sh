#!/bin/sh

#初期設定
WAIT_TIME="3"
HEAD="20"

#ネットワーク情報を表示
while :
do
        clear
        netstat -i
        echo
        echo "----------------------------------------------------------------------"
        echo "サービスポートの状態"
        netstat -natu | egrep 'LISTEN|ESTABLISHED' | head -$HEAD
        sleep $WAIT_TIME
done

exit 0
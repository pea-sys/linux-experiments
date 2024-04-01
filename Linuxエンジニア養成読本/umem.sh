#!/bin/sh

#一時ファイル作成
tmpfile1=`mktemp -t tmp.XXXXXXXXXX` || exit 1
tmpfile2=`mktemp -t tmp.XXXXXXXXXX` || exit 1

#psで実行中プロセスのユーザー名と使用メモリを取得
ps -ae -o user,rss --sort=user --no-headers | tr -s " " > $tmpfile1 2> /dev/null

#ユーザー名リストを作成
cut -d " " -f 1 $tmpfile1 | uniq > $tmpfile2 2> /dev/null

#ユーザー毎の使用メモリを集計
for user in $(cat $tmpfile2); do
        add="0";
        for memory in $(grep $user $tmpfile1 | cut -d " " -f2); do
                add=`expr $add + $memory`
        done    
        if [ $add -gt 1024 ]; then
                add=`expr $add / 1024`
                echo "$user $add M byte"
        else    
                echo "$user $add K byte"
        fi      
done    

#一時ファイルの削除
rm -f $tmpfile1 $tmpfile2
exit 0
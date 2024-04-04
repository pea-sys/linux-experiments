#!/bin/sh
#curl -O https://standards-oui.ieee.org/oui/oui.txt
#初期設定
OUIFILE="./oui.txt"

if  [ ! -f $OUIFILE ]; then
        echo "OUI file not found"
        exit 1
fi

#一時ファイルの作成
tmpfile=`mktemp -t tmp.XXXXXXXXXX` || exit 1

#ARPテーブルの出力
/sbin/arp -n | grep ether > $tmpfile 2> /dev/null

#ARPテーブルを1行ずつ読み込み、IPアドレスとMACアドレスを表示
#その際、ベンダコードをOUIファイルで検索し表示
while read address hwtype hwaddress flags mask iface;
do
        vendor_c=`echo $hwaddress | cut -d ":" -f 1-3 | sed "s/:/-/g"`
        vendor_n=`grep -i $vendor_c $OUIFILE | cut -f 3`
        vendor_n=`echo $vendor_n | sed -e "s/[\r\n]\+//g"`
        echo  "$address \t\t $hwaddress($vendor_n)"
done < $tmpfile

#一時ファイルの削除
rm -f $tmpfile

exit 0
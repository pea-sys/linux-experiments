dns サーバーソフトウェアのインストール

```
sudo apt-get install bind9
```

ゾーンファイルの作成

```
cd etc/bind/
cp db.local db.sub.dnsstudy.jp
vi db.sub.dnsstudy.jp
```

ゾーンファイルを次のように修正しました

```
$TTL    86400
@       IN      SOA     ns.sub.dnsstudy.jp. root.sub.dnsstudy.jp. (
                        20240320        ; Serial
                        10800           ; Refresh
                        900             ; Retry
                        1814400         ; Expire
                        900 )           ; Negative Cache TTL
;
        IN      NS      ns.sub.dnsstudy.jp.
ns      IN      A       192.168.0.36
www     IN      A       192.168.0.36
```

ゾーンファイルの権限を確認します

```
ls -l db.sub.dnsstudy.jp
-rw-r--r-- 1 root bind 248 Mar 20 10:17 db.sub.dnsstudy.jp
```

設定ファイルをバックアップ後に編集します

```
cp -p /etc/bind/named.conf /etc/bind/named.conf.org
vi /etc/bind/named.conf
```

次のように編集しました

```
options {
        listen-on port 53 { 192.168.0.36 ; };
        listen-on-v6 { none; };
        directory "/var/cache/bind";
        allow-query { any; };
        allow-query-cache { none; };
        recursion no;
        allow-recursion { none; };

        pid-file "var/run/named/named.pid";
        session-keyfile "var/run/named/session.key";
};

controls {
        inet 127.0.0.1 port 953 allow { localhost; };
        inet ::1 port 953 allow { localhost; };
};

zone "sub.dnsstudy.jp" IN {
        type master;
        file "/etc/bind/db.sub.dnsstudy.jp";
};
```

ゾーンファイルと設定ファイルの記載内容に誤りがないかチェックします

```
named-checkconf  -z /etc/bind/named.conf
zone sub.dnsstudy.jp/IN: loaded serial 20240320
```

bind を起動します

```
systemctl start bind9
```

bind の状態を確認します

```
rndc status
version: BIND 9.18.18-0ubuntu0.22.04.2-Ubuntu (Extended Support Version) <id:>
running on localhost: Linux x86_64 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2
boot time: Wed, 20 Mar 2024 01:02:24 GMT
last configured: Wed, 20 Mar 2024 01:02:24 GMT
configuration file: /etc/bind/named.conf
CPUs found: 4
worker threads: 4
UDP listeners per interface: 4
number of zones: 102 (97 automatic)
debug level: 0
xfers running: 0
xfers deferred: 0
soa queries in progress: 0
query logging is OFF
recursive clients: 0/900/1000
tcp clients: 0/150
TCP high-water: 0
server is up and running
```

bind の named プロセスが指定した IP アドレス(192,168.0.36)の TCP 及び UDB のポート 53、
ループバックアドレス(127.0.0.1)のポート 953 で動作していることを確認します

```
netstat -lnutp
稼働中のインターネット接続 (サーバのみ)
Proto 受信-Q 送信-Q 内部アドレス            外部アドレス            状態       PID/Program name
tcp        0      0 192.168.0.36:53         0.0.0.0:*               LISTEN      6420/named
udp        0      0 192.168.0.36:53         0.0.0.0:*                           6420/named
tcp        0      0 127.0.0.1:953           0.0.0.0:*               LISTEN      6420/named
udp        0      0 127.0.0.1:53            0.0.0.0:*                           6420/named
tcp6       0      0 ::1:953                 :::*                    LISTEN      6420/named
```

dig コマンドの動作確認

status が NOEEROR であるため問題なさそうです  
dig コマンドの flag の見方は正直良くわからないので別途勉強

```
dig @192.168.0.36 www.sub.dnsstudy A +norec

; <<>> DiG 9.18.18-0ubuntu0.22.04.2-Ubuntu <<>> @192.168.0.36 www.sub.dnsstudy A +norec
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 49243
;; flags: qr ra ad; QUERY: 1, ANSWER: 0, AUTHORITY: 13, ADDITIONAL: 27

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
; COOKIE: 1a944b2dd2a6fe1d0100000065fa3f6e69444f1edb637838 (good)
;; QUESTION SECTION:
;www.sub.dnsstudy.              IN      A

;; AUTHORITY SECTION:
.                       515890  IN      NS      l.root-servers.net.
.                       515890  IN      NS      b.root-servers.net.
.                       515890  IN      NS      m.root-servers.net.
.                       515890  IN      NS      d.root-servers.net.
.                       515890  IN      NS      e.root-servers.net.
.                       515890  IN      NS      f.root-servers.net.
.                       515890  IN      NS      g.root-servers.net.
.                       515890  IN      NS      h.root-servers.net.
.                       515890  IN      NS      i.root-servers.net.
.                       515890  IN      NS      j.root-servers.net.
.                       515890  IN      NS      k.root-servers.net.
.                       515890  IN      NS      a.root-servers.net.
.                       515890  IN      NS      c.root-servers.net.

;; ADDITIONAL SECTION:
a.root-servers.net.     515890  IN      A       198.41.0.4
b.root-servers.net.     515890  IN      A       170.247.170.2
c.root-servers.net.     515890  IN      A       192.33.4.12
d.root-servers.net.     515890  IN      A       199.7.91.13
e.root-servers.net.     515890  IN      A       192.203.230.10
f.root-servers.net.     515890  IN      A       192.5.5.241
g.root-servers.net.     515890  IN      A       192.112.36.4
h.root-servers.net.     515890  IN      A       198.97.190.53
i.root-servers.net.     515890  IN      A       192.36.148.17
j.root-servers.net.     515890  IN      A       192.58.128.30
k.root-servers.net.     515890  IN      A       193.0.14.129
l.root-servers.net.     515890  IN      A       199.7.83.42
m.root-servers.net.     515890  IN      A       202.12.27.33
a.root-servers.net.     515890  IN      AAAA    2001:503:ba3e::2:30
b.root-servers.net.     515890  IN      AAAA    2801:1b8:10::b
c.root-servers.net.     515890  IN      AAAA    2001:500:2::c
d.root-servers.net.     515890  IN      AAAA    2001:500:2d::d
e.root-servers.net.     515890  IN      AAAA    2001:500:a8::e
f.root-servers.net.     515890  IN      AAAA    2001:500:2f::f
g.root-servers.net.     515890  IN      AAAA    2001:500:12::d0d
h.root-servers.net.     515890  IN      AAAA    2001:500:1::53
i.root-servers.net.     515890  IN      AAAA    2001:7fe::53
j.root-servers.net.     515890  IN      AAAA    2001:503:c27::2:30
k.root-servers.net.     515890  IN      AAAA    2001:7fd::1
l.root-servers.net.     515890  IN      AAAA    2001:500:9f::42
m.root-servers.net.     515890  IN      AAAA    2001:dc3::35

;; Query time: 0 msec
;; SERVER: 192.168.0.36#53(192.168.0.36) (UDP)
;; WHEN: Wed Mar 20 10:44:14 JST 2024
;; MSG SIZE  rcvd: 868
```

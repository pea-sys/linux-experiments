# Ubuntu に Samba 導入

導入環境

```
uname -a
Linux masami-L 6.5.0-25-generic #25~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Feb 20 16:09:15 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
```

samba サービスのインストール

```
sudo apt-get install samba
sudo systemctl restart smbd
sudo systemctl restart nmbd
```

共有フォルダアクセス用のアカウント作成

```
sudo adduser samba
sudo pdbedit -a samba
```

共有フォルダ作成

```
sudo mkdir -p /srv/samba/share
sudo chown samba /srv/samba/share/
```

samba 設定ファイルの編集

```
sudo vi /etc/samba/smb.conf
```

今回は固有のユーザー(名称 samba)だけアクセスできる共有フォルダを用意

```
[samba]
browseable = yes
writeable = yes
path = /srv/samba/share
force create mode = 664
force directory mode = 775
force user = samba
valid users = samba
```

ifconfig で IP アドレスを調べて、Windows エクスプローラーからアクセスしてみます

![auth](https://github.com/pea-sys/linux-experiments/assets/49807271/3269d52b-5956-4667-b6ce-c93fb7f569b5)

ログイン情報を入力すると、Ubuntu のフォルダにアクセスできるようになりました
![ss](https://github.com/pea-sys/linux-experiments/assets/49807271/9d9e014c-dfa6-4c57-8c1c-d28e8033154e)

実際にはファイルサーバーは名前解決するか固定 IP アドレスにした方が良いと思います

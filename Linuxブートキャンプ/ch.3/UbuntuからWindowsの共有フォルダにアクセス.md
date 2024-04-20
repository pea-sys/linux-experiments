Ubuntu に smbclient をインストール

```
sudo apt install smbclient
```

共有フォルダにアクセス

```
masami@masami-L /u/src> smbclient //192.168.0.123/share -U masami
Password for [WORKGROUP\masami]:
Try "help" to get a list of possible commands.
```

共有フォルダ内のファイルを列挙

```
smb: \> dir
  .                                   D        0  Wed Mar 20 08:43:39 2024
  ..                                DHS        0  Wed Mar 20 08:38:59 2024
  sample.txt                          A        3  Wed Mar 20 08:43:43 2024

                12799999 blocks of size 4096. 12658349 blocks available
```

共有フォルダ内のファイル取得

```
smb: \> get sample.txt
Error opening local file sample.txt
```

smbclient の実行ユーザーがローカルにファイル書き込み権限がないため、エラーになりました。
権限があるユーザーで再度 smbclient からアクセス後、get

```
smb: \> get sample.txt
getting file \sample.txt of size 3 as sample.txt (0.2 KiloBytes/sec) (average 0.2 KiloBytes/sec)
```

共有フォルダにファイルアップロード

```
smb: \> put TestProgram1-io-perf-randomread.txt
putting file TestProgram1-io-perf-randomread.txt as \TestProgram1-io-perf-randomread.txt (71.6 kb/s) (average 71.6 kb/s)

smb: \> dir
  .                                   D        0  Wed Mar 20 08:51:04 2024
  ..                                DHS        0  Wed Mar 20 08:38:59 2024
  sample.txt                          A        3  Wed Mar 20 08:43:43 2024
  TestProgram1-io-perf-randomread.txt      A     2053  Wed Mar 20 08:51:04 2024

                12799999 blocks of size 4096. 12658348 blocks available
```

共有フォルダとの接続を切断

```
smb: \> quit
```

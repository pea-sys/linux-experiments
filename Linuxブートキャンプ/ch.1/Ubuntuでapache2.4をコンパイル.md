```
sudo wget http://ftp.tsukuba.wide.ad.jp/software/apach
e/httpd/httpd-2.4.51.tar.gz
sudo tar xvfs httpd-2.4.51.tar.gz
cd httpd-2.4.51/
sudo ./configure
```

私の環境ではコンパイルエラーが発生しました

```
configure: error: APR not found.  Please read the documentation.
```

apr と apr-util をインストールします

```
sudo wget http://ftp.riken.jp/net/apache/apr/apr-1.7.4.tar.gz
sudo tar xvfs apr-1.7.4.tar.gz
sudo mv apr-1.7.4 httpd-2.4.51//srclib/apr
sudo wget http://ftp.riken.jp/net/apache/apr/apr-util-1.6.
3.tar.gz
sudo tar xvfs apr-util-1.6.3.tar.gz
sudo mv apr-util-1.6.3 httpd-2.4.51/srclib/apr-util
```

```
cd httpd-2.4.51/
sudo ./configure
```

私の環境ではまだコンパイルエラーが発生しました

```
configure: error: pcre-config for libpcre not found. PCRE is required and available from http://pcre.org/
```

pcre をインストールします

```

sudo apt-get install libpcre3-dev
```

apache をコンパイルします

```
 ./configure --with-pcre=/usr/src/pcre2-10.22/pc
re2-config
make
make install
```

起動しようとすると設定不足で怒られるが、
一応インストールは成功

```
sh httpd
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
(98)Address already in use: AH00072: make_sock: could not bind to address [::]:80
(98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:80
no listening sockets available, shutting down
AH00015: Unable to open logs
```

以上

```
#リポジトリ更新
sudo apt update
#パッケージ更新
sudo apt upgrade
sudo apt full-upgrade
#不要パッケージ削除
sudo apt autoremove -y
#一旦PC再起動
#タイムゾーン設定
sudo timedatectl set-local-rtc true
#Gitインストール
sudo apt install -y git
#Git初期設定
git config --global user.name "pea-sys"
git config --global user.email pea98258@gmail.com
#不要ソフト削除
sudo apt purge libreoffice-common
#curlインストール
sudo apt install curl
#sarを使う場合
sudo systemctl enable sysstat && sudo systemctl start sysstat
# https://github.com/iovisor/bpftrace/issues/2168
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
sudo tee -a /etc/apt/sources.list.d/ddebs.list
sudo apt install ubuntu-dbgsym-keyring
sudo apt update
sudo apt install bpftrace-dbgsym

#Desktop用
#ゴミ箱をデスクトップに配置
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash true
#フォルダ名を英語にする
LANG=C xdg-user-dirs-gtk-update
#右クリックで空ファイルを作成可能にする
touch Templates/空のドキュメント

#vimをHuge版にする
sudo apt-get install vim -y
#好みのシェル導入
sudo apt install fish -y
chsh -s /usr/bin/fish

#クライシスツール
sudo apt install sysstat
sudo apt install linux-tools-common
sudo apt install linux-tools-`uname -r` -y
sudo apt install bpftrace
sudo apt install trace-cmd
sudo apt install nicstat
sudo apt install ethtool
sudo apt install tiptop
sudo apt install msr-tools
sudo apt install fatrace -y
sudo apt install fio -y
sudo apt install iotop -y
sudo apt install blktrace -y
sudo apt install ioping -y
sudo apt install net-tools
#bccツール  各コマンド実行時にsuffixとして「-bpfcc」を付加 
sudo apt-get install bpfcc-tools linux-headers-6.2.0-35-generic

#FlameGraph
cd /usr/local/src/
sudo git clone https://github.com/brendangregg/FlameGraph
cd FlameGraph
sudo wget https://raw.githubusercontent.com/brendangregg/FlameGraph/master/stackcollapse-perf.pl
sudo wget https://raw.githubusercontent.com/brendangregg/FlameGraph/master/flamegraph.pl
```



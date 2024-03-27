# linux-in-practice-2nd

「Linuxのしくみ 増補改訂版」の実験コードです


![TH160_9784297131487](https://github.com/pea-sys/linux-experiments/assets/49807271/9d98582d-05ea-4955-a084-8d8015f0e607)

# 実験プログラム実行環境の作成

お手元のUbuntu 20.04環境で本書の実験プログラムを実行する際は、以下のコマンドを実行して必要パッケージのインストールおよびユーザ設定をしてください。

```console
$ sudo apt update && sudo apt install binutils build-essential golang sysstat python3-matplotlib python3-pil fonts-takao fio qemu-kvm virt-manager libvirt-clients virtinst jq docker.io containerd libvirt-daemon-system
$ sudo adduser `id -un` libvirt
$ sudo adduser `id -un` libvirt-qemu
$ sudo adduser `id -un` kvm
```

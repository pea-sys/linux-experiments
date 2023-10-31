# VS CodeからSSH接続する

Linuxの勉強を始めた当初から、Ubuntu環境にはTeraTermを使ってSSH接続していましたが、VS CodeからもSSH接続できるということで乗り換えました。

* VSCodeを起動します
* ExtensionからRemote Developmentをインストールします
![1](https://github.com/pea-sys/linux-experiments/assets/49807271/f5e6e352-9fb3-43bc-becb-1cc8ee00d682)

* Remotes(Tunnels/SSH)に設定して、SSH接続するターミナルの情報をconfigファイルに設定します
![2](https://github.com/pea-sys/linux-experiments/assets/49807271/d6baad68-0121-4be3-9637-bfcf9b2ae86a)

* SSH接続を試みると、パスワード入力を求められるので入力します
![3](https://github.com/pea-sys/linux-experiments/assets/49807271/e008af01-572d-4e32-b371-7d85e48867d7)

* 接続成功するとVSCodeのSSH接続ステータスが次のようになります
![4](https://github.com/pea-sys/linux-experiments/assets/49807271/bcdb6d54-dac8-4389-be30-66e2361a839a)


* 複数人で同じターミナルにSSH接続する場合は、VSCodeのファイルスキャンが非常に負荷をかける場合があるので、無効にしておくといいでしょう
* [File] -> [Preferences] -> [Settings]を選択し、検索窓に「Watcher Exclude」と入力する
![5](https://github.com/pea-sys/linux-experiments/assets/49807271/66364db4-721b-4dc7-9b70-2581a57ff997)

* [Add Pattern]をクリックし、「**」を追加する
* 設定を反映するためにVSCodeを再起動します
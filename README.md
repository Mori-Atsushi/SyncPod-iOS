# SyncPod-iOS
SyncPodのiOSアプリ用のリポジトリです。

## 必要環境
* Xcode 9.1
* [Swimat](https://github.com/Jintin/Swimat)
* [Carthage](https://github.com/Carthage/Carthage)

### Xcode 9.1
[App Store](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12)からインストールする。

### Swimat
1. 次のコマンドを実行する。
```sh
brew cask install swimat
```

2. [システム設定] -> [機能拡張] -> [Xcode Source Editor] -> [Swimat]にチェックを入れる。

### 
1. 次のコマンドを実行する。
```sh
brew install carthage
```

2. 外部ライブラリをビルドする
```sh
carthage update --platform iOS
```

## セットアップ
1. 次のコマンドを実行する。
```sh
git clone git@github.com:Mori-Atsushi/SyncPod-iOS.git
cd SyncPod-iOS
```

2. Xcodeでプロジェクトを開く

3. デバッグ用実機端末を接続し、Runから起動させる。

## 著者
* [森 篤史](@Mori-Atsushi)

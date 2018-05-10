# SyncPod-iOS
SyncPodのiOSアプリ用のリポジトリです。

## 必要環境
* Xcode 9.1
* [SwiftLint](https://github.com/realm/SwiftLint)
* [Carthage](https://github.com/Carthage/Carthage)

### Xcode 9.1
[App Store](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12)からインストールする。

### SwiftLint
1. 次のコマンドを実行する。
```shbrew install swiftlint
```

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

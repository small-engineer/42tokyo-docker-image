# 42Tokyo Docker イメージ

42Tokyoでの開発用の Docker イメージを作成するプロジェクトです。このイメージには、C/C++ 開発に必要な各種コンパイラやツールチェーンが含まれています。

## 特徴

- **ベースイメージ**：Ubuntu 22.04
- **コンパイラ**：
  - GCC 10、11、12
  - Clang 12
- **Python 環境**：
  - Python 3.10
  - `pyyaml` パッケージ
- **その他ツール**：
  - `make`
  - `cmake`
  - `gdb`
  - `valgrind`

## ファイル構成

- **Dockerfile**：メインの Docker イメージをビルドするための設定ファイル。
- **install.yml**：追加でインストールしたいパッケージや設定を定義する YAML ファイル。
- **install_script.py**：`install.yml` を読み込み、指定されたパッケージをインストールするスクリプト。
- **test/Dockerfile**：ビルドしたイメージをテストするための Dockerfile。

## ビルド方法

### Docker イメージのビルド

プロジェクトのルートディレクトリで以下のコマンドを実行します。

```
docker build -t 42image:latest .
```

#### `USE_YAML` ビルド引数

`install.yml` を使用したインストールをスキップしたい場合は、以下のようにビルド引数を指定します。

```
docker build --build-arg USE_YAML=false -t 42image:latest .
```

## 使用方法

ビルドした Docker イメージを使用してコンテナを起動します。

```
docker run -it 42image:latest
```

これにより、設定済みの開発環境でシェルアクセスが可能になります。

## テスト方法

`test` ディレクトリには、イメージの動作を検証するための Dockerfile が含まれています。

## ファイル詳細

- **Dockerfile**

  メインの Docker イメージをビルドするための設定ファイルです。以下の内容が含まれています。

  - ベースイメージとして `ubuntu:22.04` を使用
  - タイムゾーンと `DEBIAN_FRONTEND` の環境変数を設定
  - 必要なパッケージのインストールとクリーンアップ
  - `install.yml` と `install_script.py` のコピーと実行
  - 複数バージョンの GCC と Clang のインストールと設定
  - デフォルトコマンドとして `/bin/bash` を指定

- **install.yml**

  追加でインストールしたいパッケージや設定を定義する YAML ファイルです。
  デフォルトで42のマシンの内容をそのままベースにしたファイルが入っています。

- **install_script.py**

  `install.yml` を読み込み、指定されたパッケージをインストールする Python スクリプトです。


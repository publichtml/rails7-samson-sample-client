# README

[samson-sample](https://github.com/publichtml/samson-sample) とペアで使うために作られた Rails7 アプリ。

トップページに `Welcome` とだけ表示されるもの。
docker コンテナは cap deploy できるようにセットアップされている。

# Usage

docker-compose を事前にインストールしておく。
ssh 認証に使う公開鍵を用意しておく。

```
$ bundle install

$ cp /path/to/id_rsa.pub .

$ docker-compose build
$ docker-compose up -d

$ bundle exec cap production deploy

$ curl http://localhost:4000  # テキストで "Welcome" とだけ返ってくる

$ ssh root@localhost -p 4022
```

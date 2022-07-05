# Typing APP

Dokcerfileのビルド、コンテナの立ち上げ
```
docker-compose build
docker-compose up -d
```

webコンテナに入る
```
docker-compose exec web /bin/bash
```

初回（パッケージの取得、DBの作成）
```
cd typing
mix deps.get
mix ecto.create
```

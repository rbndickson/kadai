# 課題

写真管理のRuby on Railsアプリケーションです。

## Requirements

- Ruby: 2.4.4以上
- Rails: 5.2.1以上
- SQLite3
- Bundler (`gem install bundler`)

## To Start

1. インストールする。

```
git clone https://github.com/rbndickson/kadai.git
cd kadai
```

2. Gemを全てインストールする。

```
bundle install
```

3. 新しい`master.key`と`credentials.yml.enc`を生成する。
   MyTweetのOAuthの情報を入力する。
```

mv config/credentials.yml.enc ./tmp/
EDITOR=vim rails credentials:edit
```

```yml
my_tweet:
  client_id:
  client_secret:
```

4. 動かす。

```
rake db:migrate
rake db:seed
rails server
```

5. ログインする。
- `ユーザーID: Alice`
- `パスワード: passwordalice`
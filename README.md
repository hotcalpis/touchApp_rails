## 概要
[*touchApp*](https://www.touchapp.tk/)は作成したアプリケーションを紹介するための記事投稿サイトです。
小さなアウトプットも歓迎します。
<br>

## 作成した機能
- ユーザーの登録/認証/編集
  - 認証用メールの送信
  - Githubで登録/ログイン
  - SNSリンク/アイコンアップロード
- 記事の投稿/編集
  - コードの挿入、シンタックスハイライト
  - タグ機能
- 記事にいいね、コメントをする
- 検索機能(タイトルと本文から1単語のみ)
- 管理者権限/管理者用画面
- テストユーザーでログインする

## 使用した技術
### 言語/フレームワークなど
- Ruby  2.6.5
- Rails 5.2.4.1
- Rspec
- haml
- Bootstrap

### インフラ
- AWS (EC2, RDS-MySQL, S3, Route53, SES)
  - 他、ACMでSSL証明書を発行しALBへの通信をhttps化、IAMで権限管理など

### 環境/ツール
- Windows10/Vagrant/Virtualbox/CentOS7.0
- VScode
- Docker
- CircleCI (Rubocop/Rspecを連携)
<br>

## アプリの紹介記事
[touchAppを公開しました! - touchApp](https://www.touchapp.tk/posts/1)

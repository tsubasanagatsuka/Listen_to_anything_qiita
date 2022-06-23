# アプリケーション名
listen to anything qiita

# アプリケーション概要
LINEに検索したいキーワードを入力しQiitaから新着５件の情報を取り出してくれる。 

#　URL
(https://listen-qiita.herokuapp.com/)

# 利用方法

## 目標投稿
1. LINEからlisten to anything qiitaを友だち登録する。
2. 検索したいキーワードを入力する(複数のキーワード可)

## 取得したいキーワードの情報が返ってくる
1. 検索結果が表示される(新着5件降順)

# アプリケーションを作成した背景
サイトに直接いって情報を探すのではなく手軽なSNSというツールを使ってそこから検索できれば
学習の時間をもっと集中しながらできるのではないかと考えました。
履歴としても残り、自分がどういった問題に対して何を検索したのかが分かることも制作する上で魅力的だな思いました。

# 洗い出した要件
[要件定義書] (https://docs.google.com/spreadsheets/d/1XwjYaOsKVfOlNjXTRmPX7qeAbpFdr3E7pzuNiJlEck4/edit#gid=982722306)

# 実装した機能についての画像やGIFおよびその説明
[![Image from Gyazo](https://i.gyazo.com/c100df2bdb2957f5fca8f48099dd7f37.gif)](https://gyazo.com/c100df2bdb2957f5fca8f48099dd7f37)
[![Image from Gyazo](https://i.gyazo.com/5e6d43412d0c5c1719ac26c55589461c.png)](https://gyazo.com/5e6d43412d0c5c1719ac26c55589461c)

LINEに検索したいキーワードを送信する

## URl
`https://listen-qiita.herokuapp.com/callback` 
<br>
LINEbotにメッセージが送られていた際に先のURLにPOST(リクエスト）が走る。

```
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/callback', to: 'linebot#callback'

end
```
linebot_controllerのcallbackが走る。
```
 def callback
    qiita = QiitaApi.new
    body = request.body.read
 end
```

qiita_apiを代入する
（この中でユーザーからの検索ワードをqiitaから探し出してくる）

```
class QiitaApi < ApplicationRecord
  def search_results(keywords)
    require 'json'
    require 'net/https'
    require 'uri'

    array_key = keywords.split
    keys =  array_key.map{|item| URI.encode_www_form_component(item)}
    query = keys.join('+')
    uri = URI.parse("https://qiita.com/api/v2/items?query=body:#{query}")
    res = Net::HTTP.get_response(uri)

    messages = []
    (0..4).each do |i|
      messages << JSON.parse(res.response.body)[i]["url"]
    end
    return messages
  end
end

```

linebot_controllerが走り情報をユーザーに返す

```
  events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          reply_messages = []
          messages = qiita.search_results(event.message['text'])
          messages.each do |message|
            reply_messages << {type: "text", text: message}
          end
          client.reply_message(event['replyToken'], reply_messages)
        end
      end
    end

    "OK"
  end
end

```

# 実装予定の機能
現在、LGTM数での降順5件を表示することを目指しています。
javascriptなどで見え方を変えれたらもっと使いやすいものができると思いそこも思案中です。

# 開発環境
・バックエンド


# ローカルでの動作方法
起動
rails sするターミナルとは別のターミナルでngrokを起動します

$ ./ngrok http 3000

コマンド入力した後にLINEを開きキーワードを打つとメッセージが返ってきます。

# 工夫したポイント
複数のキーワードから検索を実行することが難しかったのですが
実装した部分でもあったので頑張りました。
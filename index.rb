require 'json'
require 'net/https'
require 'uri'

query = URI.encode_www_form_component(ENV['KEYWORD'])
uri = URI.parse("https://qiita.com/api/v2/items?query=body:#{query}")
res = Net::HTTP.get_response(uri)

# puts JSON.parse(res.response.body)[0.1.2.3.4]["url"]
# 上のクラスを順番に出力するために下のようにeachさせる
(0..4).each do |i|
  puts JSON.parse(res.response.body)[i]["url"]
end
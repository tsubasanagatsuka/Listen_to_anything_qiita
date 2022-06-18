require 'json'
require 'net/https'
require 'uri'

query = URI.encode_www_form_component(ENV['KEYWORD'])
uri = URI.parse("https://qiita.com/api/v2/items?query=title:#{query}")
res = Net::HTTP.get_response(uri)

puts JSON.parse(res.response.body)[0]["title"]


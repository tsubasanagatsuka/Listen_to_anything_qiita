# require 'json'
# require 'net/https'
require 'uri'

# str = "ラズパイ".encode("unicode")
# uri = URI.parse("https://qiita.com/api/v2/items?query=title:#{str}")
url = "https://qiita.com/api/v2/items?query=title:"
query = URI.encode_www_form_component('ラズパイ')
# res = Net::HTTP.get_response(uri)

# puts JSON.parse(res.response.body)[0]["title"]
puts url + query


require 'json'
require 'net/https'
require 'uri'

  uri = URI.parse("https://qiita.com/api/v2/users/#{ENV['USER_ID']}/items?page=1&per_page=100")
  res = Net::HTTP.get_response(uri)

  puts JSON.parse(res.response.body)[0][:title]


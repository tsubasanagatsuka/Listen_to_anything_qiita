require 'uri'
# puts ARGV[0] + "+" + ARGV[1] + "+" + ARGV[2]
# puts ARGV.size
# puts "うんこ".size
puts ARGV.join('+')
# p ARGV
# p putsは違う　pは形を変えずに出力　putsは要素ごとに改行して出力　米　ARGV = []
query = URI.encode_www_form_component(ARGV.join('+'))
puts query
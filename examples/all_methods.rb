# This library is not a gem. Relative require.
require_relative '../lib/glutton_pinboard.rb'

pinboard = GluttonPinboard.new 'username:YOUR_AUTH_TOKEN_HERE'

all_my_tags = pinboard.tags_get
puts "I have used #{all_my_tags.size} tags."

all_my_posts = pinboard.posts_all
puts "I have saved #{all_my_posts.size} links."
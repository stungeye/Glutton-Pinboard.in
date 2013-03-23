require_relative '../lib/glutton_pinboard.rb'

pinboard = GluttonPinboard.new 'username:YOUR_AUTH_TOKEN_HERE'

require 'pp'
#
#API_VERSION = 'v1'.freeze
#base_uri = "https://api.pinboard.in/#{API_VERSION}/"
#url = base_uri + 'tags/get?auth_token=username:YOUR_AUTH_TOKEN_HERE'
#puts url
#response = HTTParty.get(url)
#puts response.class

response = pinboard.q('/tags/get')
puts response['tags']['tag'].size

response = pinboard.tags_get
puts response.size
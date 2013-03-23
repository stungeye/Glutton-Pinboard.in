require 'httparty'
require 'glutton_ratelimit'

class GluttonPinboard
  include HTTParty
  extend GluttonRatelimit
  
  API_VERSION = 'v1'.freeze
  base_uri "https://api.pinboard.in/#{API_VERSION}/"
  format :xml
  
  class QueryStatus   < StandardError; end
  class QueryArgument < StandardError; end
  class Unauthorized  < StandardError; end
  class RateLimit     < StandardError; end
  class NotFound      < StandardError; end
  class UnknownHTTP   < StandardError; end
  
  def initialize( key )
    self.class.default_params :auth_token => key
  end
  
  def q( method, options = {})
    response = self.class.get( method, options)
    raise_errors(response, method)
    response.parsed_response
  end
  
  def tags_get
    q('/tags/get')['tags']['tag']
  end
  
  def posts_all
    q('/posts/all')['posts']['post']
  end
  
  # Throws custom Errors for specific HTTP responses.
  def raise_errors( response, method)
    case response.code.to_i
      when 400
        raise QueryArgument, "method: #{method}"
      when 401..403
        raise Unauthorized,  "method: #{method}"
      when 404
        raise NotFound, "method: #{method}"
      when 429
        raise RateLimit, "method: #{method}"
      when 200 
        if response.parsed_response.nil? || response.parsed_response.size == 0
          raise UnknownHTTP, "Received a 200 HTTP response with an empty payload. method: #{method}"
        end
    end
  end
  
  rate_limit :tags_get, 1, 3    # Limit tag fetching to one call every 3 seconds.
  rate_limit :posts_all, 1, 305 # Limit all post fetching to one call every 5 minutes.
end

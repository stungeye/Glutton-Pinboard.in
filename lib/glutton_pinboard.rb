require 'httparty'
require 'glutton_ratelimit'


class GluttonPinboard
  include HTTParty
  API_VERSION = 'v1'.freeze
  base_uri "https://api.pinboard.in/#{API_VERSION}/"
  format :xml
  
  class QueryStatus< StandardError; end
  class QueryArgument< StandardError; end
  class Unauthorized < StandardError; end
  class RateLimite< StandardError; end
  class NotFound < StandardError; end
  class UnknownHTTP < StandardError; end
  
  def initialize( key )
    self.class.default_params :auth_token => key
  end
  
  def q( method, options = {})
    response = self.class.get( method, options)
    raise_errors(response, method, options)
    response.parsed_response
  end
  
  def tags_get
    q('/tags/get')['tags']['tag']
  end
  
  def raise_errors( response, method, options )
    case response.code.to_i
      when 400
        raise QueryArgument, "#{options.inspect}"
      when 403
        raise Unauthorized,  "#{options.inspect}"
      when 404
        raise NotFound, options.inspect
      when 429
        raise RateLimit, "#{option.inspect}"
      when 200 # Is it overkill to test all successfully received requests like this?
        if response.parsed_response.nil? || response.parsed_response.size == 0
          raise UnknownHTTP, "Received a 200 HTTP response with an empty payload. #{options.inspect}"
        end
    end
  end
  
end

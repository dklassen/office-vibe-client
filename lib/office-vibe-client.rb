require 'her'

module OfficeVibe
  class << self
    def api
      @api ||= Her::API.new()
    end

    def setup(opts = {})
      options = {url: "https://app.officevibe.com/api/v2/"}
      options = options.merge(opts)

      api.setup(options) do |c|
        c.use Faraday::Request::UrlEncoded
        c.use Her::Middleware::JsonApiParser
        c.use Faraday::Adapter::NetHttp
        c.use Faraday::Response::RaiseError
        c.response :logger
        c.authorization :Bearer, options[:token]
      end
    end
  end
end

require 'office-vibe/base_api'
require 'office-vibe/group'
require 'office-vibe/user'

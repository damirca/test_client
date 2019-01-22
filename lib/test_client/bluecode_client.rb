require 'faraday'
require 'faraday_middleware'

module TestClient
  class BluecodeClient
    URL = 'http://localhost:4000'

    def initialize
      @conn = Faraday.new(url: URL) do |conn|
        conn.request :json
        conn.response :json, :content_type => /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

    def clear
      send_request { conn.delete('/api/v1/digits') }
    end

    def checksum
      response = send_request { conn.get('/api/v1/digits/checksum') }
      return unless response && response.status == 200

      response.body['checksum']
    end

    def store(digits)
      send_request do
        conn.post do |req|
          req.url '/api/v1/digits'
          req.body = "{ \"digits\": \"#{digits}\" }"
        end
      end
    end

    private

    attr_reader :conn

    def send_request
      yield
    rescue Faraday::ClientError
      nil
    end
  end
end

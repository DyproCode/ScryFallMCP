require "net/http"
module ScryFallApi
  class BaseClient
    BASE_URL = "https://api.scryfall.com"

    private

    def get(path, params = {})
      uri = URI(BASE_URL + path)
      uri.query = URI.encode_www_form(params) if params.any?
      req = Net::HTTP::Get.new(uri)
      req["Accept"] = "application/json"
      req["User-Agent"] = "ScryFallMCP/0.1"
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
    end
  end
end

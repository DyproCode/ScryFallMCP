module ScryFallApi
  class CardsClient < ScryFallApi::BaseClient
    def find_by_id(id:)
      response = get("/cards/#{id}")
      body = JSON.parse(response.body)
      raise ScryFallApi::Error.new(body["details"], status: response.code) unless response.is_a?(Net::HTTPSuccess)
      body
    end

    def find(card_name:)
      response = get("/cards/named", fuzzy: card_name)
      body = JSON.parse(response.body)
      raise ScryFallApi::Error.new(body["details"], status: response.code) unless response.is_a?(Net::HTTPSuccess)
      body
    end

    def search(q:, page: 1)
      response = get("/cards/search", q:, page:)
      body = JSON.parse(response.body)
      raise ScryFallApi::Error.new(body["details"], status: response.code) unless response.is_a?(Net::HTTPSuccess)
      body
    end

    def random(q: nil)
      response = get("/cards/random", q:)
      body = JSON.parse(response.body)
      raise ScryFallApi::Error.new(body["details"], status: response.code) unless response.is_a?(Net::HTTPSuccess)
      body
    end
  end
end

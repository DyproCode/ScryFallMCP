class SearchCardTool < MCP::Tool
  description <<~TEXT
                searches for a group of cards based on a query. Use this when the user asks you to find cards of a specific type.
                Only 175 cards are returned at a time, you may have to use page to get additional cards depending on your query
              TEXT

  input_schema(
    properties: {
      q: { type: "string" },
      page: { type: "integer" },
      fields: {
        type: "array",
        items: { type: "string", enum:
          [
            "mana_cost",
            "name",
            "power",
            "toughness",
            "loyalty",
            "oracle_text",
            "keywords",
            "legalities",
            "type_line",
            "card_faces",
            "cmc",
            "color_identity",
            "colors",
            "color_indicator",
            "defense",
            "edhrec_rank",
            "game_changer",
            "reserved"
          ]
        } }
    },
    required: [ "q" ]
  )

  def self.call(q:, page: 1, fields: nil, server_context:)
    cards = ScryFallApi::CardsClient.new.search(q:, page:)
    cards["data"].map! { |card| card.slice(*fields) } unless fields.nil?
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(cards) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ], error: true)
  end
end

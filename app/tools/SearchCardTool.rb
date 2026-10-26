class SearchCardTool < MCP::Tool
  description <<~TEXT
                Searches for a group of cards based on a query. Use this when the user asks you to find cards of a specific type.
                Only 175 cards are returned at a time, you may have to use page to get additional cards depending on your query
              TEXT

  input_schema(
    properties: {
      q: { type: "string" },
      page: { type: "integer" },
      fields: Filterable::FIELDS_SCHEMA
    },
    required: [ "q" ]
  )

  def self.call(q:, page: 1, fields: nil, server_context:)
    cards = ScryFallApi::CardsClient.new.search(q:, page:)
    cards["data"] = cards["data"].map { |card| card.slice(*fields) } if fields
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(cards) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ], error: true)
  end
end

class FindCardTool < MCP::Tool
  description <<~TEXT
                Looks up card by name, with options fields to get the information that you want -> returns JSON of card information, all info by default
                Use when looking for card art, card information or anything else regarding magic cards.
              TEXT

    input_schema(
    properties:
      { card_name: { type: "string" },
        fields: Filterable::FIELDS_SCHEMA
      },
    required: [ "card_name" ]
  )

  def self.call(card_name:, fields: nil, server_context:)
    card = ScryFallApi::CardsClient.new.find(card_name:)
    card = fields ? card.slice(*fields) : card
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(card) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ], error: true)
  end
end

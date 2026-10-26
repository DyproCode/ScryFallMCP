class FindCardByIdTool < MCP::Tool
  description "Use this to find a card by it's scryfall id. Good if you already have a looked for a large subset of cards and want more info on a specific card"

  input_schema(
    properties: {
      id: { type: "string" },
      fields: Filterable::FIELDS_SCHEMA
    },
    required: [ "id" ]
  )

  def self.call(id:, fields: nil, server_context:)
    card = ScryFallApi::CardsClient.new.find_by_id(id:)
    card = fields ? card.slice(*fields) : card
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(card) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ], error: true)
  end
end

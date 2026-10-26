class RandomCardTool < MCP::Tool
  description "This tools allows you to get a random card with the option of a query param. Use when the user asks for a random card"

  input_schema(
    properties: {
      q: { type: "string" },
      fields: Filterable::FIELDS_SCHEMA
    }
  )

  def self.call(q: nil, fields: nil, server_context:)
    card = ScryFallApi::CardsClient.new.random(q:)
    card = fields ? card.slice(*fields) : card
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(card) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ], error: true)
  end
end

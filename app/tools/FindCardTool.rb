class FindCardTool < MCP::Tool
  description <<~TEXT
                Looks up card by name, with options fields to get the information that you want -> returns JSON of card information, all info by default
                Use when looking for card art, card information or anything else regarding magic cards.
              TEXT

    input_schema(
    properties:
      { card_name: { type: "string" },
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
            ] }
        } },
    required: [ "card_name" ]
  )

  def self.call(card_name:, fields: nil, server_context:)
    card = ScryFallApi::CardsClient.new.find(card_name:)
    card = fields.nil? ? card : card.slice(*fields)
    MCP::Tool::Response.new([ { type: "text", text: JSON.pretty_generate(card) } ])
  rescue ScryFallApi::Error => e
    MCP::Tool::Response.new([ { type: "text", text: e.message } ],
      error: true)
  end
end

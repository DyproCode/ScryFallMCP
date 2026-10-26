module Filterable
  FIELDS_SCHEMA =  {
    type: "array",
    items: { type: "string", enum:
      [
        "id",
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
      ] } }.freeze
end

class World < Draco::World
  include Draco::Common::World
  
  # Sprite provided by Rogue Yun
  # http://www.bay12forums.com/smf/index.php?topic=144897.0
  # License: Public Domain
  entity Tileset,
    atlas: {
      path: 'sprites/simple-mood-16x16.png',
      sprite_lookup: SPRITE_LOOKUP
    }, as: :tileset

  entity Level, as: :level
  entity Player, as: :player

  systems GenerateLevel, RenderBackground, RenderLevel, RenderGlyph, HandleInput
end
class RenderGlyph < Draco::System
  filter Position, Renderable

  def tick(args)
    tileset = world.tileset
    glyphs = entities.map do |entity|
      {
        x: entity.position.x,
        y: entity.position.y,
        tile_key: entity.renderable.glyph,
        color_name: entity.renderable.fg
      }
    end

    glyphs.each do |glyph|
      args.outputs.sprites << tileset.tile(
        GRID_PADDING + glyph.x * DESTINATION_TILE_SIZE, 
        GRID_PADDING + glyph.y * DESTINATION_TILE_SIZE,
        DESTINATION_TILE_SIZE,
        DESTINATION_TILE_SIZE,
        glyph.tile_key, 
        COLOR_NAME_RGB[glyph.color_name.to_sym]
      )
    end
  end
end
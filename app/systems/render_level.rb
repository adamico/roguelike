class RenderLevel < Draco::System
  filter LevelData

  def tick(args)
    draw_tiles(args)
  end

  protected

  def draw_tiles(args)
    tileset = world.tileset
    glyphs = world.level.level_data.raw_data

    x = 0
    y = 0

    glyphs.each do |glyph|
      args.outputs.sprites << tileset.tile(
        GRID_PADDING + x * DESTINATION_TILE_SIZE,
        GRID_PADDING + y * DESTINATION_TILE_SIZE,
        DESTINATION_TILE_SIZE,
        DESTINATION_TILE_SIZE,
        glyph, 
        COLOR_NAME_RGB[:white]
      )
      x += 1
      if x > 63
        x = 0
        y += 1
      end
    end
  end
end
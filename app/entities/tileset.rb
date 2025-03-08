class Tileset < Draco::Entity
  component Atlas

  def tile(x, y, w, h, tile_row_column_or_key, color)
    row_or_key, column = tile_row_column_or_key
    row, column = row_or_key, column
    row, column = atlas.sprite_lookup[row_or_key] if !column

    if !row
      member_name = member_name_as_code(tile_row_column_or_key)
      raise "Unabled to find a sprite for #{member_name}. Make sure the value exists in app/sprite_lookup.rb."
    end

    {
      x: x,
      y: y,
      w: w,
      h: h,
      tile_x: column * 16,
      tile_y: row * 16,
      tile_w: 16,
      tile_h: 16,
      r: color.r,
      g: color.g,
      b: color.b,
      a: color.a,
      path: atlas.path
    }
  end

  protected

  def member_name_as_code(raw_member_name)
    if raw_member_name.is_a? Symbol
      ":#{raw_member_name}"
    elsif raw_member_name.is_a? String
      "#{raw_member_name}"
    elsif raw_member_name.is_a? Fixnum
      "#{raw_member_name}"
    else
      "UNKNOWN: #{raw_member_name}"
    end
  end
end
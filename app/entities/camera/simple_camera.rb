class SimpleCamera < Draco::Entity
  component Position
  component Draco::Tag(:default_camera)
  component Size, width: $gtk.args.grid.w, height: $gtk.args.grid.h
  component Zoom

  def set_zoom(scale = 1.0, options={})
    options[:scale] = scale
    options[:rate] ||= 0.1
    self.components << Zoom.new(options)
  end

  def follow(entity_or_id)
    target_id = entity_or_id.class.ancestors.include?(Draco::Entity) ? entity_or_id.id : entity_or_id
    self.components << CameraTarget.new(id: target_id)
  end

  def move_to(position_attrs={})
    camera_position = Draco::Entity.new
    camera_position.components << Size.new(width: size.width, height: size.height)
    camera_position.components << Position.new(position_attrs)
    $gtk.args.state.world.entities << camera_position
    self.components << CameraTarget.new(id: camera_position.id)
  end

  def shake(duration = 15)
    self.components << CameraShake.new(started_at: $gtk.args.state.tick_count, duration: duration)
  end

  def translate_pos(window_pos)
    {
      x: window_pos.x - position.x.to_i,
      y: window_pos.y - position.y.to_i
    }
  end

  def from_absolute(window_pos)
    {
      x: window_pos.x + position.x.to_i,
      y: window_pos.y + position.y.to_i
    }
  end
end

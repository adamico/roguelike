class HandleInput < Draco::System
  UP = ['up', 'kp_eight', 'k']
  DOWN = ['down', 'kp_two', 'j']
  RIGHT = ['right', 'kp_six', 'l']
  LEFT = ['left', 'kp_four', 'h']

  filter Tag(:player_controlled), Position

  def tick(args)
    entities.each do |entity|
      move_entity(args, entity)
    end
  end

  def move_entity(args, entity)
    new_x = entity.position.x
    new_y = entity.position.y

    if UP.any? { |k| args.inputs.keyboard.key_down.send(k) }
      new_y += 1
    elsif DOWN.any? { |k| args.inputs.keyboard.key_down.send(k) }
      new_y -= 1
    elsif RIGHT.any? { |k| args.inputs.keyboard.key_down.send(k) }
      new_x += 1
    elsif LEFT.any? { |k| args.inputs.keyboard.key_down.send(k) }
      new_x -= 1
    end

    if can_move_to(new_x, new_y)
      entity.position.x = new_x
      entity.position.y = new_y
    end
  end

  def can_move_to(x, y)
    destination_index = xy_index(x, y)
    world.level.level_data.raw_data[destination_index] != 'wall'
  end

  def xy_index(x, y)
    (y * MAP_X_MAX) + x
  end
end
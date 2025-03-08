class ShakeCamera < Draco::System
  filter CameraShake

  def tick(args)
    entity = entities.first
    return if entity.nil?

    max_angle = 0.05
    max_offset = 5
    shake = 3

    entity.camera_shake.position ||= { x: entity.position.x, y: entity.position.y }
    entity.position.x = entity.camera_shake.position.x
    entity.position.y = entity.camera_shake.position.x

    world.filter(Draco::Tag(:shakeable)).each do |e|
      e.rotation.angle = 0
    end

    if (entity.camera_shake.started_at + entity.camera_shake.duration).elapsed?
      entity.components.delete(entity.components[:camera_shake])
      return
    end

    angle = max_angle * shake * get_random_float
    offset_x = max_offset * shake * get_random_float
    offset_y = max_offset * shake * get_random_float

    entity.position.x += offset_x
    entity.position.y += offset_y

    world.filter(Draco::Tag(:shakeable)).each do |e|
      e.rotation.anchor_x = 0.5
      e.rotation.anchor_y = 0.5
      e.rotation.angle += angle
    end
  end

  def get_random_float
    rand * (1.0 - -1.0) + 1.0
  end

end

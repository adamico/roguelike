class ControlCamera < Draco::System
  filter Position, Size, CameraTarget

  def tick(args)
    entities.each do |entity|
      target = world.entities[entity.camera_target.id].first

      break unless target && target.components[:position]

      x = target.position.x - (entity.size.width / 2) + target.size.width / 2
      y = target.position.y - (entity.size.height / 2) + target.size.height / 2

      angle = args.geometry.angle_to [entity.position.x, entity.position.y], [x, y]

      speed = target.components[:speed] ? target.speed.speed : 6
      distance_x = x - entity.position.x
      distance_y = y - entity.position.y
      speed_x = speed.lesser(distance_x.abs).round(2)
      speed_y = speed.lesser(distance_y.abs).round(2)

      entity.position.dx = angle.vector_x.round(2) * speed_x
      entity.position.dy = angle.vector_y.round(2) * speed_y

      entity.position.x = (entity.position.x + entity.position.dx).round
      entity.position.y = (entity.position.y + entity.position.dy).round
    end
  end
end

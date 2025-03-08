class GenerateLevel < Draco::System
  MAX_ROOMS = 30
  MIN_ROOM_SIZE = 6
  MAX_ROOM_SIZE = 10

  def tick(args)
    level = world.level
    player = world.player
    map_data_and_rooms = generate

    level.level_data.raw_data = map_data_and_rooms.map_data

    rooms = map_data_and_rooms.rooms

    first_room_center = Geometry.rect_center_point(rooms.first)

    player.position.x = first_room_center.x.to_i
    player.position.y = first_room_center.y.to_i

    world.systems.delete(GenerateLevel)
  end
  
  private

  def generate
    map = Array.new(64*32, 'wall')
    rooms = []
    
    MAX_ROOMS.times do
      w = Numeric.rand(MIN_ROOM_SIZE..MAX_ROOM_SIZE)
      h = Numeric.rand(MIN_ROOM_SIZE..MAX_ROOM_SIZE)
      x = Numeric.rand(1..(MAP_X_MAX - w - 1)) - 1
      y = Numeric.rand(1..(MAP_Y_MAX - h - 1)) - 1

      room = { x: x, y: y, w: w, h: h }
      ok = rooms.none? do |other_room|
        Geometry.intersect_rect?(room, other_room.scale_rect(1.5, 0.5, 0.5))
      end

      if ok
        add_room(room, map)

        if rooms.any?
          center = Geometry.rect_center_point(room)
          prev_center = Geometry.rect_center_point(rooms[-1])
          create_tunnels(prev_center, center, map)
        end

        rooms << room
      end
    end

    { map_data: map, rooms: rooms }
  end

  def add_room(room, map)
    x1, x2 = room.x, room.x + room.w
    y1, y2 = room.y, room.y + room.h
    (y1..y2).each do |y|
      (x1..x2).each do |x|
        map[xy_index(x, y)] = 'floor'
      end
    end
  end

  def create_tunnels(prev_center, center, map)
    prev_center_x, prev_center_y = prev_center.x.to_i, prev_center.y.to_i
    center_x, center_y = center.x.to_i, center.y.to_i

    if Numeric.rand(0..1).zero?
      vertical_args = [prev_center_y, center_y, prev_center_x, map, :vertical]
      horizontal_args = [prev_center_x, center_x, center_y, map, :horizontal]
      tunnels = Numeric.rand(0..1).zero? ? [vertical_args, horizontal_args] : [horizontal_args, vertical_args]
      tunnels.each { |args| add_tunnel(*args) }
    end
  end

  def add_tunnel(start, finish, fixed, map, direction)
    range = [start, finish].min..[start, finish].max
    range.each do |variable|
      index_argument = direction == :horizontal ? [variable, fixed] : [fixed, variable]
      index = xy_index(*index_argument)
      map[index] = 'floor' if index > 0 && index < MAP_X_MAX*MAP_Y_MAX - 1
    end
  end

  def generate_test_level
    map = Array.new(64*32, 'floor')
    (0..63).each do |x|
      map[xy_index(x, 0)] = 'wall'
      map[xy_index(x, MAP_Y_MAX - 1)] = 'wall'
    end

    (0..31).each do |y|
      map[xy_index(0, y)] = 'wall'
      map[xy_index(MAP_X_MAX - 1, y)] = 'wall'
    end

    400.times do
      x = Numeric.rand(1..MAP_X_MAX - 1)
      y = Numeric.rand(1..MAP_Y_MAX - 1)
      index = xy_index(x, y)
      map[index] = 'wall' if index != xy_index(MAP_X_MAX/2, MAP_Y_MAX/2)
    end

    map
  end

  def xy_index(x, y)
    (y * MAP_X_MAX) + x
  end
end
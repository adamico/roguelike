class UpdateZoom < Draco::System
  filter Zoom

  def tick(args)
    entity = entities.first
    return if entity.nil?

    prev = (entity.zoom.prev || 1).round(2)

    diff = (entity.zoom.scale - prev).round(2)
    rate = entity.zoom.rate
    return unless diff.abs > rate

    entity.zoom.prev = prev + (rate * diff)

    if Object.const_defined?('MapObject')
      map_objects = world.filter(MapObject)
      map_objects.each do |e|
        e.components << Zoomable.new unless e.components[:zoomable]
      end
    end

    zoomables = world.filter(Zoomable)
    zoomables.each do |e|
      e.zoomable.original_size ||= e.size.serialize #if e.zoomable.original_size.nil?
      e.size.width = e.zoomable.original_size[:width] * entity.zoom.prev
      e.size.height = e.zoomable.original_size[:height] * entity.zoom.prev

      e.zoomable.original_position ||= e.position.serialize #if e.zoomable.original_position.nil?
      e.position.x = e.zoomable.original_position[:x] * entity.zoom.prev
      e.position.y = e.zoomable.original_position[:y] * entity.zoom.prev
    end
  end

end

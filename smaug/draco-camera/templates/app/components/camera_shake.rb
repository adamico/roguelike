class CameraShake < Draco::Component
  attribute :position, default: { x: 0, y: 0 }
  attribute :started_at
  attribute :duration
end

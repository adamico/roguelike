class Player < Draco::Entity
  component Tag(:player_controlled)
  component Position, x: 32, y: 16
  component Renderable, glyph: '@', fg: 'white'
end
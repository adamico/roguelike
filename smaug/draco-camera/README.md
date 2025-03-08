# Draco Camera

> A simple camera entity with features like zoom, move to position, follow a target, and shake effect

## Example

```ruby
class ExampleWorld < Draco::World
  include Draco::Camera

  entity Player, as: :player

  def initialize
    super

    # Follow an entity object or id to keep it centered on the screen
    camera.follow player

    # Or move the camera to a specific position
    camera.move_to x: 100, y: 100

    # Adjust the scale with animated transitions between zoom levels
    camera.set_zoom 8.0, rate: 0.2

    # Trigger a camera shake animation for 30 ticks
    camera.shake 30
  end
end
```

Check the `examples/` directory for a complete demo containing several more examples you can learn from.

---

## Installation

If you don't already have a game project, run `smaug new` to create one.

### Add dependencies

```bash
$ smaug add draco
$ smaug add draco-common
```

And then...

```bash
$ smaug add draco-camera
```

```ruby
# app/main.rb
require 'smaug.rb'

def tick args
  args.state.world ||= HelloWorld.new
  args.state.world.tick(args)
end
```

Next, create a World and include `Draco::Camera`.

```ruby
# app/worlds/hello_world.rb
class ExampleWorld < Draco::World
  include Draco::Camera

  def initialize
    super
    camera.move_to x: 0, y: 0
  end

  # Your camera is accessible globally at $gtk.args.state.world.camera
end
```

Start the game with `smaug run`.

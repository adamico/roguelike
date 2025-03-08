require 'smaug.rb'

require 'app/constants.rb'

require 'app/components/atlas.rb'
require 'app/components/level_data.rb'
require 'app/components/renderable.rb'

require 'app/entities/background.rb'
require 'app/entities/level.rb'
require 'app/entities/player.rb'
require 'app/entities/tileset.rb'

require 'app/systems/generate_level.rb'
require 'app/systems/handle_input.rb'
require 'app/systems/render_background.rb'
require 'app/systems/render_glyph.rb'
require 'app/systems/render_level.rb'

require 'app/worlds/world.rb'

def tick(args)
  args.state.world ||= World.new
  args.state.world.tick(args)
end

$gtk.reset
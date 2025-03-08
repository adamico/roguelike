module Draco
  module Camera

    def self.included(mod)
      mod.extend(ClassMethods)
      mod.prepend(InstanceMethods)

      RenderTarget.class_eval do
        component Zoomable
        component Tag(:shakeable)
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      attr_reader :camera

      def after_initialize
        super

        @camera = SimpleCamera.new
        @entities.add @camera

        camera.components << Zoom.new(scale: 1.0)

        @systems << UpdateZoom
        @systems << ControlCamera
        @systems << ShakeCamera
      end

      #def before_tick(context)
      #  super
      #end

    end
  end
end

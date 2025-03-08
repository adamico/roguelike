class RenderBackground < Draco::System
  def tick(args)
    args.outputs.solids << [
      {
        x: 0,
        y: 0,
        w: args.grid.w,
        h: args.grid.h,
        r: 0,
        g: 0,
        b: 0
      }
    ]
  end
end
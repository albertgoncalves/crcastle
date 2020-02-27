class Point
  @x : UInt8
  @y : UInt8

  def initialize(rng : Random) : Nil
    @x = rng.rand(UInt8)
    @y = rng.rand(UInt8)
  end

  def x : UInt8
    @x
  end

  def y : UInt8
    @y
  end
end

macro pretty_print(points)
  {{points}}.each do |p|
    printf("{x: %3d, y: %3d}\n", p.x, p.y)
  end
  print('\n')
end

macro sort_by(static_array, field)
  {{static_array}}.to_slice.sort! do |a, b|
    a.{{field}}.to_i32 - b.{{field}}.to_i32
  end
end

def main : Nil
  rng = Random.new
  points = StaticArray(Point, 10).new do |_|
    Point.new(rng)
  end
  pretty_print(points)
  {% for field in ["x", "y"] %}
    sort_by(points, {{field.id}})
    pretty_print(points)
  {% end %}
end

main

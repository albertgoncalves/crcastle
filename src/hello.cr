require "benchmark"
require "json"
require "spec"

N = 12_i32

{% for t in ["class", "struct"] %}
  {{t.id}} Point{{t.capitalize.id}}
    getter(x : UInt8, y : UInt8)

    def initialize(rng : Random) : Nil
      @x = rng.rand(UInt8)
      @y = rng.rand(UInt8)
    end
  end
{% end %}

def points_to_json(points : StaticArray(_, _)) : String
  JSON.build do |json|
    json.array do
      points.each do |p|
        json.object do
          json.field("x", p.x)
          json.field("y", p.y)
        end
      end
    end
  end
end

macro sort_by(static_array, field)
  {{static_array}}.to_slice.sort! do |a, b|
    a.{{field}}.to_i32 - b.{{field}}.to_i32
  end
end

macro make_array(t, rng)
  StaticArray({{t}}, N).new do |_|
    {{t}}.new({{rng}})
  end
end

def main : Nil
  Benchmark.ips do |b|
    {% for t in ["class", "struct"] %}
      b.report("StaticArray(Point{{t.capitalize.id}}, #{N})") do
        rng = Random.new
        make_array(Point{{t.capitalize.id}}, rng)
      end
    {% end %}
  end

  rng = Random.new
  points : StaticArray(PointStruct, N) = make_array(PointStruct, rng)
  puts points_to_json(points)
  {% for field in ["x", "y"] %}
    sort_by(points, {{field.id}})
    puts points_to_json(points)
  {% end %}

  describe "something" do
    it "should be fine" do
      true.should be_true
    end

    it "should not be fine" do
      true.should be_false
    end
  end
end

main

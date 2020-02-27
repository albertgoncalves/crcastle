def f(&block : String -> Nil) : String
  x = yield "Second?"
  puts "First"
  puts x
  puts yield "Third"
  "Hello, world!"
end

def g(x : String) : String
  x
end

def main
  x : String = f do |x|
    g x
  end
  x.each_char do |char|
    print char
  end
  print '\n'
end

main

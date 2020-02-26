def f : String
  "Hello, world!"
end

def main
  x : String = f()
  x.each_char do |char|
    print char
  end
  print '\n'
end

main

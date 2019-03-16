require "minruby"
require "pp"

def ppp(x)
  PP.pp( x, $stdout, 20 )
end

def evaluate(tree)
  case tree[0]
  when "lit"
    tree[1]
  when "+"
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left + right
  when "-"
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left - right
  when "*"
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left * right
  when "/"
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left / right
  else
    raise "unknown tree item: #{tree[0]}"
  end  
end

def test(x, expected)
  tree = minruby_parse(x)
  ppp tree
  value = evaluate( tree )
  if value==expected
    puts "value is #{value}, okay."
  else
    puts "value is #{value}, want #{expected}."
  end
end

test( "(1+2)*3+4", 13 )

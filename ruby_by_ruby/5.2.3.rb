require "minruby"
require "pp"
require "stringio"

def ppp(x)
  PP.pp( x, $stdout, 30 )
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
  when "func_call"
    p(evaluate(tree[2]))
  when "stmts"
    i=1
    last = nil
    while tree[i]
      last = evaluate(tree[i])
      i=i+1
    end
    last
  else
    raise "unknown tree item: #{tree[0]}"
  end
end

def test_arithmetic_op(x, expected)
  tree = minruby_parse(x)
  #ppp tree
  value = evaluate( tree )
  if value==expected
    puts "value is #{value}, okay."
  else
    puts "value is #{value}, want #{expected}."
  end
end

def output
  io = StringIO.new
  prev = $stdout
  $stdout = io
  val = nil
  begin
    val = yield
  ensure
    $stdout = prev
  end
  [io.string, val]
end

def test_stmts( x, exp_out, exp_value )
  tree = minruby_parse(x)
  #ppp tree
  out, value = output{ evaluate( tree ) }
  p [ x, out, value ]
  if exp_out==out && exp_value==value
    puts "value is #{value}, out is #{out.inspect}, okay."
  else
    puts "value is #{value}, want #{exp_value}."
    puts "out is #{out.inspect}, want #{exp_out.inspect}."
  end
end

test_arithmetic_op( "(1+2)*3+4", 13 )
test_stmts( "p(1+2)", "3\n", 3 )
test_stmts(<<ST, "12\n44\n", 44)
p(3*4)
p(4*(5+6))
ST

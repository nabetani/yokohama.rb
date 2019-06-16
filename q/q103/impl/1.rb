# frozen_string_literal: true

require "minitest/autorun"
require "json"

class MaskedNumbers
  def initialize(mask)
    @mask = mask
    @digits = @mask.digits(2)
    @count = @mask.to_s(2).gsub("0", "" ).to_i(2)
  end

  private 
  def expand(i)
    d0 = i.digits(2)
    d = @digits.map{ |e| e==1 ? (d0.shift||0) : 0 }
    d.reverse.join.to_i(2)
  end

  public
  def first(n)
    (1..@count).take(n).map{ |i| expand(i) }
  end

  def last(n)
    @count.downto(1).take(n).map{ |i| expand(i) }.reverse
  end
end

def solve( src )
  m = MaskedNumbers.new(src.to_i(16))
  nums = m.first(15+1)
  if 15<nums.size
    [nums.take(13).join(","), m.last(2).join(",")].join(",...,")
  else
    nums.join(",")
  end
end

if ! ARGV[0] || ! File.exist?( ARGV[0] )
  raise "you should specify json file as ARGV[0]"
end

class TestYokohamaRb103 < Minitest::Test
  json_string = File.open( ARGV[0], &:read )
  data = JSON.parse( json_string, symbolize_names:true )
  data[:test_data].each do | number:, src:, expected: |
    define_method( :"test_#{number}" ) do
      actual = solve(src)
      assert_equal( expected, actual )
    end
  end
end

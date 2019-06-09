require "minitest/autorun"
require "json"

def solve(src)
  mask = src.to_i(16)
  matches = (1..mask).select{ |e| (e & mask)==e }
  if 15<matches.size
    [matches[0,13].join(","),matches[-2,2].join(",")].join(",...,")
  else
    matches.join(",")
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

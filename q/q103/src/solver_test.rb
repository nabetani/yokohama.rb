# frozen_string_literal: true

require 'minitest/autorun'
require_relative "solver"

def solve_slow(src)
  mask = src.to_i(16)
  matches = (1..mask).select{ |e| (e & mask)==e }
  if 15<matches.size
    [matches[0,13].join(","),matches[-2,2].join(",")].join(",...,")
  else
    matches.join(",")
  end
end

class SolverTest < Minitest::Test
  def test_samples
    (1..10000).each do |n|
      src = n.to_s(16)
      expected = solve_slow(src)
      actual = solve( src )
      assert_equal expected, actual, "src=#{src}"
    end
  end
end

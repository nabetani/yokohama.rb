# frozen_string_literal: true

require_relative "solver"

EVENT_URL="https://yokohamarb.doorkeeper.jp/events/91907"
EVENT_NUMBER = 103
EVENT_ID="Yokohama.rb ##{EVENT_NUMBER}"
QIITA_URL = nil
TITLE="マスクしても同じ数 #{EVENT_ID}"

S0="1a"
S1="5"
S2=0b111110111.to_s(16)

SAMPLES = [
  S0,
  S1,
  S2,
] + [
  %w(
    ff f a f0f0f
    55555 aaaaa 33333
  ),
  [
    0b110011,
    0b1110111,
    0b11101110111,
    0b1001100111,
    2**19+1,
    3*2**18+3,
  ].map{ |e| e.to_s(16) }
].flatten.uniq.sort_by{ |x| [ [x,solve(x)].join.size, x ] }

def check(s)
  val = s.to_i(16)
  raise s unless val.to_s(16) == s
  raise s unless 0<=val && Math.log2(val)<=20
end

SAMPLES.each do |s|
  check(s)
end

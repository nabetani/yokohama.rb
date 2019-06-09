# frozen_string_literal: true

require_relative "solver"

EVENT_URL="https://yokohamarb.doorkeeper.jp/events/91907"
EVENT_NUMBER = 103
EVENT_ID="Yokohama.rb ##{EVENT_NUMBER}"
QIITA_URL = nil
TITLE="マスクしても同じ数 #{EVENT_ID}"

ALEN=15
ALEN_HEAD=13
ALEN_TAIL=ALEN-ALEN_HEAD
S0="1a"
S1="aaa"
S2=0b111110111.to_s(16)
BITS=28


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
    14,
    (1<<BITS)-1,
    (0b11<<(BITS-2))|3,
    (0b111<<(BITS-3))|3,
    (0b111<<(BITS-3)),
    (0b1111<<(BITS-4)),
    (0b11111<<(BITS-5)),
    (1..(BITS-1)).map{ |n|
      e = (("0"*n+"1")*10)
      e.to_i(2) & ((1<<BITS)-1)
    },
    Array.new(10){ |n|
      rng=Random.new(n)
      rng.rand(1<<BITS) & rng.rand(1<<BITS)
    }
  ].flatten.map{ |e| e.to_s(16) }
].flatten.uniq.sort_by{ |x| [ [x,solve(x)].join.size, x ] }

def check(s)
  val = s.to_i(16)
  raise s unless val.to_s(16) == s
  raise s unless 0<=val && Math.log2(val)<=BITS
end

SAMPLES.each do |s|
  check(s)
end

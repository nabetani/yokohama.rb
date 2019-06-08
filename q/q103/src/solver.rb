# frozen_string_literal: true


class MaskedNumbers
  def initialize(mask)
    @mask = mask
    @count = @mask.to_s(2).gsub("0", "" ).to_i(2)
    ch="a".dup
    @pattern = @mask.to_s(2).reverse.gsub( "1" ){ ch.succ! } # 20bitなのでこれでよい。
  end

  private 
  def expand(i)
    ch="a".dup
    ix=-1
    s=i.to_s(2).reverse
    expanded = (?b..?z).inject(@pattern) do |acc,ch|
      acc = acc.gsub(ch){ s[ix+=1]||"0" }
    end
    expanded.reverse.to_i(2)
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

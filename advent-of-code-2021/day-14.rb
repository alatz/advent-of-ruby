require 'set'
require 'pp'

path = File.expand_path('input/input14.txt')
input = File.read(path).split("\n")

def solution1(data)
  str, _, *pairs = data
  h = Hash.new { |h,k| h[k] = nil }
  pairs.each { |p|
    k, v = p.scan(/\w+/)
    h[k] = v
  }

  steps = 10
  step = 1
  while step <= steps
    i = 0
    tmp = ""
    while i < str.size-1
      key = str[i] + str[i+1]
      if !h[key].nil?
        tmp += str[i] + h[key]
      else
        tmp += str[i]
      end
      i += 1
    end

    tmp += str[-1]
    str = tmp

    step += 1
  end

  tallys = str.chars.tally.values

  tallys.max - tallys.min
end


def solution2(data)
  str, _, *pairs = data
  h = Hash.new { |h,k| h[k] = nil }
  pairs.each { |p|
    k, v = p.scan(/\w+/)
    h[k] = v
  }
  letters = h.keys.map(&:chars).join.chars.uniq
  tbl = Hash.new { |h,k| h[k] = 0 }
  letters.each { |a| letters.each { |b| tbl[a+b] = 0 } }

  i = 0
  while i < str.size-1
    key = str[i] + str[i+1]
    tbl[key] += 1 if !h[key].nil?
    i += 1
  end

  steps = 40
  step = 1
  while step <= steps
    n_tbl = Hash.new { |h,k| h[k] = 0 }
    tbl.each { |k,v| 
      n_tbl[k[0]+h[k]] += v
      n_tbl[h[k]+k[1]] += v
    }
    tbl = n_tbl
    step += 1
  end

  res = Hash.new { |h,k| h[k] = 0 }
  letters.each { |l|
    # correct for one-off error
    res["#{l}1"] = tbl.filter { |x| x.match(/#{l}\w/) }
    res["#{l}2"] = tbl.filter { |x| x.match(/\w#{l}/) }
  }

  ans = res.map { |k,v| v.values.sum }
  ans.max - ans.min
end

pp "part 1: " + solution1(input).to_s
pp "part 2: " + solution2(input).to_s


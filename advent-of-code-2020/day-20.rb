require 'set'
require 'pp'

path = File.expand_path('input/input20.txt')
input = File.read(path).split("\n")

input = input.map { |x| x == "" ? "---" : x + "-"  }
  .join.gsub("Tile ", "").gsub(":", "").gsub("#", "1").gsub(".", "0")
  .split("----").map { |x| x.split("-") }

def solution1(input)
  t = Hash.new { |h, k| h[k] = Hash.new(0) }
  r = Hash.new { |h, k| h[k] = 0 }

  input.each { |x|
    id, *tile = x;
    r[tile.first.to_i(2)] += 1
    r[tile.first.reverse.to_i(2)] += 1
    r[tile.last.to_i(2)] += 1
    r[tile.last.reverse.to_i(2)] += 1
    left = ""; tile.each { |ll| left += ll[0] }
    r[left.to_i(2)] += 1
    r[left.reverse.to_i(2)] += 1
    right = ""; tile.each { |rr| right += rr[tile.size-1] }
    r[right.to_i(2)] += 1
    r[right.reverse.to_i(2)] += 1
  }

  input.each { |x|
    id, *tile = x;
    t[id][tile.first.to_i(2)] = r[tile.first.to_i(2)]
    t[id][tile.first.reverse.to_i(2)] = r[tile.first.reverse.to_i(2)]
    t[id][tile.last.to_i(2)] = r[tile.last.to_i(2)]
    t[id][tile.last.reverse.to_i(2)] = r[tile.last.reverse.to_i(2)]
    left = ""; tile.each { |ll| left += ll[0] }
    t[id][left.to_i(2)] = r[left.to_i(2)]
    t[id][left.reverse.to_i(2)] = r[left.reverse.to_i(2)]
    right = ""; tile.each { |rr| right += rr[tile.size-1] }
    t[id][right.to_i(2)] = r[right.to_i(2)]
    t[id][right.reverse.to_i(2)] = r[right.reverse.to_i(2)]
  }

  res = t.each_with_object([]) { |(k,v), o|
    o << k.to_i if v.select { |k2, v2| v2 >= 2 }.count <= 4
  }

  res.reduce(&:*)
end

def solution2(input)
  # todo
end

pp solution1 input
pp solution2 input


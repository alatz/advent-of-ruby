require 'set'
require 'pp'

path = File.expand_path('input/input22.txt')
input = File.read(path).split("\n")
  .map { |x| (x == "") ? "---" : x + "," }
  .join.gsub(/Player \d:,/, "").split("---")
  .map { |x| x.split(",") }.map { |x| x.map(&:to_i) }

def solution1(input)
  p1, p2 = input.map(&:reverse)

  while !p1.empty? && !p2.empty?
    c1, c2 = p1.pop, p2.pop
    (c1 > c2) ? p1.unshift(c2,c1) : p2.unshift(c1,c2)
  end

  winner = p1.empty? ? p2 : p1

  ans = 0
  i = 0
  while i < winner.size
    ans += winner[i] * (i + 1)
    i += 1
  end

  ans
end

def solution2(input)
  # todo
end

pp solution1 input
pp solution2 input


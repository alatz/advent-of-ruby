require 'set'
require 'pp'

path = File.expand_path('input/input06.txt')
input = File.read(path).split("\n")

def solution1(input)
  input = Marshal.load(Marshal.dump(input))
    .map { |x| (x == "") ? "---" : x }
    .join.split("---").map { |x| x.strip }
  ans = 0
  input.each { |line| ans += line.chars.uniq.count }
  ans
end

def solution2(input)
  input = Marshal.load(Marshal.dump(input))
    .map { |x| x + "|" }
    .map { |x| (x == "|") ? "---" : x }
    .join.split("|---").map { |ln| ln.split("|") }

  count = 0
  input.each { |line|
    hash = Hash.new { |h, k| h[k] = 0 }
    line.each { |p| p.chars.each { |c| hash[c] += 1 } }
    count += hash.select { |_, v| v == line.size }.size
  }
  count
end

pp solution1 input
pp solution2 input


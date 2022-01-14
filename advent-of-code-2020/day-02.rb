require 'set'
require 'pp'

path = File.expand_path('input/input02.txt')
input = File.read(path).split("\n")

def solution1(input)
  valid_passowrds = 0

  input.each { |line|
    ln = line.split()
    min, max = ln[0].scan(/\d+/).map(&:to_i)
    letter = ln[1][0]
    pw = ln[2].chars

    count = 0
    pw.each { |c| count += 1 if c == letter }
    valid_passowrds += 1 if count >= min && count <= max
  }

  valid_passowrds
end

def solution2(input)
  input.select { |line|
    ln = line.split()
    min, max = ln[0].scan(/\d+/).map(&:to_i)
    c = ln[1][0]
    pw = ln[2].chars

    case1 = pw[min-1] == c && pw[max-1] != c
    case2 = pw[max-1] == c && pw[min-1] != c

    case1 || case2
  }.size
end

pp solution1 input
pp solution2 input


require 'set'
require 'pp'

path = File.expand_path('input/input06.txt')
input = File.read(path).split(",").map(&:to_i)

def solution(nums, days)
  fish = [0] * 9

  i = 0
  while i < nums.size
    fish[nums[i]] += 1
    i += 1
  end

  i = 0
  while i < days
    zeros = fish[0]
    fish.shift
    fish[6] += zeros
    fish[8] = zeros
    i += 1
  end

  fish.sum.to_s
end

pp "part 1: " + solution(input, 80)
pp "part 2: " + solution(input, 256)


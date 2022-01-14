require 'set'
require 'pp'

path = File.expand_path('input/input01.txt')
input = File.read(path).split("\n").map(&:to_i)

def solution(nums)
  counter = 0
  i = 1
  while i < nums.size
    if nums[i] > nums[i-1] 
      counter += 1
    end
    i += 1
  end

  pp "part 1: #{counter}"

  counter = 0
  i = 3
  while i < nums.size
    window_1 = nums[i-1] + nums[i-2] + nums[i-3]
    window_2 = nums[i] + nums[i-1] + nums[i-2]
    if window_2 > window_1
      counter += 1
    end
    i += 1
  end

  pp "part 2: #{counter}"
end

solution(input)


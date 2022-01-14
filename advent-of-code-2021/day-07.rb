require 'set'
require 'pp'

path = File.expand_path('input/input07.txt')
input = File.read(path).split(",").map(&:to_i)

#test_input = [16,1,2,0,4,2,7,1,2,14]

def solution1(nums)
  h = Hash.new { |h,k| h[k] = 0 } 

  i = 0
  while i < nums.max
    j = 0
    while j < nums.size
      h[i] += (i - nums[j]).abs
      j += 1
    end
    i += 1
  end

  h.values.min
end

def solution2(nums)
  h = Hash.new { |h,k| h[k] = 0 } 

  i = 0
  while i < nums.max
    j = 0
    while j < nums.size
      dist = (i - nums[j]).abs
      tri_num = (dist * (dist + 1)) / 2
      h[i] += tri_num
      j += 1
    end
    i += 1
  end

  h.values.min
end

pp solution1(input)
pp solution2(input)


require 'set'
require 'pp'

path = File.expand_path('input/input01.txt')
input = File.read(path).split("\n").map(&:to_i).sort

def solution1(nums)
  len = nums.size
  i = 0
  while i < len
    j = 0
    while j < len
      return nums[i] * nums[j] if nums[i] + nums[j] == 2020
      j += 1
    end
    i += 1
  end

  'not found'
end

def solution2(nums)
  len = nums.size
  i = 0
  while i < len
    j = 0
    while j < len
      k = 0
      while k < len
        if nums[i] + nums[j] + nums[k] == 2020
          return nums[i] * nums[j] * nums[k] 
        end
        k += 1
      end
      j += 1
    end
    i += 1
  end

  'not found'
end

pp solution1 input
pp solution2 input


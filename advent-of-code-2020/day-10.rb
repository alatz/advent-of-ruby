require 'set'
require 'pp'

path = File.expand_path('input/input10.txt')
input = File.read(path).split("\n").map(&:to_i).sort
input = [0] + input + [input.max+3]

def solution1(input)
    ones, threes = 0, 0
    i = 0
    while i < input.size-1
        diff = input[i+1] - input[i]
        threes += 1 if diff == 3
        ones += 1 if diff == 1
        i += 1
    end

    ones * threes
end


def solution2(input)
  # todo
end

pp solution1 input
pp solution2 input


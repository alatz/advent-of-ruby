require 'set'
require 'pp'

path = File.expand_path('input/input09.txt')
input = File.read(path).split("\n").map(&:to_i)

def solution1(input, preamble)
  first_number_not_found = -1

  input.each_with_index { |num, idx|
    target = idx + preamble
    found = false
    i = idx

    break if target > input.size-1

    while i < target
      break if found
      j = i+1
      while j < target
        break if found
        found = true if input[i] + input[j] == input[target]
        j += 1
      end
      i += 1
    end

    if !found
      first_number_not_found = input[target]
      break
    end
  }

  first_number_not_found
end

def solution2(input, solution)
  res = -1

  (1..input.size-1).each { |window_max|
    p1 = 0
    p2 = window_max
    while p2 < input.size
      sum = 0
      i = p1
      while i <= p2
        sum += input[i]
        i += 1
      end

      if sum == solution
        res = (p1..p2).each_with_object([]) { |x, a|
          a << input[x]
        }
        return res.min + res.max
      end
      p1 += 1
      p2 += 1
    end
  }

  res
end

pp solution1 input, 25
pp solution2 input, 133015568


require 'set'
require 'pp'

path = File.expand_path('input/input13.txt')
input = File.read(path).split("\n")

#input = [939,7,13,?x,?x,59,?x,31,19]
#input = [939,7,13,59,31,19]

def solution1(input)
  input = Marshal.load(Marshal.dump(input))
  input = [input.first.to_i] + input.last.scan(/(\d+)/).flatten.map(&:to_i)

  depart, *buses = input
  res = []
  min = 0
  buses.each { |id|
    sum = depart - (depart % id) + id
    (min = sum; res = [id, min]) if sum < min || min == 0
  }
  bus_id, time = res

  bus_id * (time - depart)
end

def solution2(input)
  input = Marshal.load(Marshal.dump(input))
    .last.split(',').map { |x| (x != 'x') ? x.to_i : x }

  i = 0
  res = -1
  i = 57764889060918
  while true
    # answer: 672754131923874
    # trick is that if i is right for some of the offsets
    # then we can incrase the counter by that i plus 
    # the next i those same numbers work for
    # EDIT: I guess I stumbled upon the chinese remainder theorem:
    # https://en.wikipedia.org/wiki/Chinese_remainder_theorem
    if (i % 13 == 0 &&
        (i+3) % 41 == 0 &&
        (i+13) % 467 == 0 &&
        (i+25) % 19 == 0 &&
        (i+30) % 17 == 0 &&
        (i+42) % 29 == 0 &&
        (i+44) % 353 == 0 &&
        (i+50) % 37 == 0 &&
        (i+67) % 23 == 0)
      res = i
      break
    end
    #pp i if i % 10000000 == 0
    i += 17083034523971
  end

  res
end

pp solution1 input
pp solution2 input


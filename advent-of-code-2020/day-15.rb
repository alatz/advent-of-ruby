require 'set'
require 'pp'

path = File.expand_path('input/input15.txt')
input = File.read(path).split("\n").first.split(",").map(&:to_i)

#input = [1,17,0,10,18,11,6]
#input = [0,3,6] #436 & #175594
#input = [3,1,2] #1836 #362

def solution(input, stop)
  h = {}

  i = 1
  input.first(input.size-1).each { |n|
    h[n] = i; i += 1
  }

  res = -1
  turn = input.size+1
  prev = input.last
  curr = -1
  while true
    if h[prev] == nil
      h[prev] = turn-1
      curr = 0
    else
      curr = turn-1 - h[prev]
      h[prev] = turn-1
    end

    if turn == stop
      res = curr
      break 
    end

    prev = curr
    turn += 1
  end

  res
end

pp solution input, 2020
pp solution input, 30000000


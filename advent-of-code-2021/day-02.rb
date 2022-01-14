require 'set'
require 'pp'

path = File.expand_path('input/input02.txt')
input = File.read(path).split("\n")
  .map{ |i| x = i.split(" "); [x.first, x.last.to_i]}

def solution1(moves)
  horz, depth = 0, 0

  i = 0
  while i < moves.size
    horz += moves[i].last if moves[i].first == "forward"
    depth -= moves[i].last if moves[i].first == "up"
    depth += moves[i].last if moves[i].first == "down"
    i += 1
  end

  horz * depth
end

def solution2(moves)
  horz, depth, aim = 0, 0, 0

  i = 0
  while i < moves.size
    if moves[i].first == "forward"
      horz += moves[i].last
      depth += aim * moves[i].last
    elsif moves[i].first == "up"
      aim -= moves[i].last
    elsif moves[i].first == "down"
      aim += moves[i].last
    end
    i += 1
  end

  horz * depth
end

pp solution1(input)
pp solution2(input)


require 'set'
require 'pp'

path = File.expand_path('input/input15.txt')
input = File.read(path).split("\n")

def solution1(lines)
  grid = lines.map { |l| l.chars.map(&:to_i) }
  y_max = grid.size-1
  x_max = grid.first.size-1
  m = Hash.new { |h,k| h[k] = {} }

  dp = -> (y, x) {
    return nil if y > y_max
    return nil if x > x_max
    return m[y][x] if m[y][x] != nil
    return grid[y][x] if y == y_max && x == x_max

    a = dp.(y+0, x+1)
    b = dp.(y+1, x+0)

    a = 100000000 if a == nil
    b = 100000000 if b == nil

    a = grid[y][x] + a
    b = grid[y][x] + b

    m[y][x] = [a, b].min

    return m[y][x]
  }

  dp.call(0,0)

  [m[0][1], m[1][0]].min
end



def solution2(lines)
  # todo
end


pp solution1(input)
pp solution2(input)


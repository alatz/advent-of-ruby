require 'set'
require 'pp'

path = File.expand_path('input/input11.txt')
input = File.read(path).split("\n")
  .map { |x| x.chars.map { |z| z.to_i } }

def solution(grid, steps)
  neg = -1000
  grid.unshift(Array.new(grid.first.size, neg))
  grid << Array.new(grid.first.size, neg)
  grid.each { |x| x.unshift(neg) }.each { |x| x << neg }

  flash_count = 0
  step = 1
  while step <= steps
    flashed, cache = [], {}
    i = 1
    while i < grid.size-1
      j = 1
      while j < grid.first.size-1
        grid[i][j] += 1
        if grid[i][j] > 9
          flashed << [i, j] 
          cache["#{i}|#{j}"] = true
        end
        j += 1
      end
      i += 1
    end

    while flashed.any?
      flash_count += 1
      y,x = flashed.pop

      inc_adj = -> (a, b) {
        grid[a][b] += 1 if cache["#{a}|#{b}"].nil?
        if grid[a][b] > 9 && cache["#{a}|#{b}"].nil?
          flashed << [a, b] 
          cache["#{a}|#{b}"] = true
        end
      }

      args = [
        [y+1,x+1], [y+1,x-1], [y-1,x+1], [y-1,x-1],
        [y-1,x], [y+1,x], [y,x+1], [y,x-1],
      ].each { |el| inc_adj.(el[0], el[1]) }
    end

    i = 1
    while i < grid.size-1
      j = 1
      while j < grid.first.size-1
        grid[i][j] = 0 if grid[i][j] > 9
        j += 1
      end
      i += 1
    end

    grid_sum = 0
    grid.each { |r| r.map { |n| grid_sum += n if n >= 0 } }

    break if grid_sum == 0

    step += 1
  end

  return [step, flash_count]
end

pp "part 1: " + solution(input, 100).last.to_s
pp "part 2: " + solution(input, 500).first.to_s


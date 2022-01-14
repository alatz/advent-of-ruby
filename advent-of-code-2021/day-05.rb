require 'set'
require 'pp'

path = File.expand_path('input/input05.txt')
input = File.read(path).split("\n").map! { |l|
  w,x,y,z = l.match(/(\d+),(\d+) -> (\d+),(\d+)/).captures
  [[w.to_i,x.to_i],[y.to_i,z.to_i]] 
}

def solve(data, diag)
  sz = 1000
  grid = Array.new(sz) { Array.new(sz, 0) }

  i = 0
  while i < data.size
    x1, y1 = data[i][0]
    x2, y2 = data[i][1]
    if data[i][0][0] == data[i][1][0]
      pt, pt_max = [y1,y2].min, [y1,y2].max
      while pt <= pt_max
        grid[pt][x1] += 1
        pt += 1
      end
    elsif data[i][0][1] == data[i][1][1]
      pt, pt_max = [x1,x2].min, [x1,x2].max
      while pt <= pt_max
        grid[y1][pt] += 1
        pt += 1
      end
    else
      if diag
        xs = []
        if (x1 - x2) > 0
          while x1 >= x2
            xs << x1
            x1 -= 1
          end
        else
          while x1 <= x2
            xs << x1
            x1 += 1
          end
        end

        ys = []
        if (y1 - y2) > 0
          while y1 >= y2
            ys << y1
            y1 -= 1
          end
        else
          while y1 <= y2
            ys << y1
            y1 += 1
          end
        end

        idx = 0
        while idx < xs.size
          grid[ys[idx]][xs[idx]] += 1
          idx += 1
        end
      end
    end

    i += 1
  end

  points = 0
  i = 0
  while i < grid.size
    j = 0
    while j < grid[0].size
      points += 1 if grid[i][j] >= 2
      j += 1
    end
    i += 1
  end

  points
end

def solution1(input)
  solve(input, false)
end

def solution2(input)
  solve(input, true)
end

pp solution1 input
pp solution2 input


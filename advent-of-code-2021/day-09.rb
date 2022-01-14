require 'set'
require 'pp'

path = File.expand_path('input/input09.txt')
input = File.read(path).split("\n")
  .map { |x| x.chars.map { |z| z.to_i } }

def solution(nums)
  # part 1
  max_x, max_y = nums[0].size, nums.size
  low_points, ys, xs = [], [], []
  nums.unshift(Array.new(max_x, 9))
  nums << Array.new(max_x, 9)
  nums.each { |x| x.unshift(9) }.each { |x| x << 9 }

  i = 0
  while i <= max_y
    j = 0
    while j <= max_x
      pt = nums[i][j]
      right = nums[i][j+1]
      left = nums[i][j-1]
      down = nums[i+1][j]
      up = nums[i-1][j]
      if pt < right && pt < down && pt < up && pt < left
        ys << i
        xs << j
        low_points << pt
      end
      j += 1
    end
    i += 1
  end

  ans_1 = low_points.map { |x| x+1 }.sum
  pp "part 1: #{ans_1}"

  # part 2
  stack, basins = [], []
  visited = Array.new(max_y+2) { Array.new(max_x+2, -1) }

  i = 0
  while i < xs.size
    stack << [xs[i], ys[i]]
    basins << []
    while stack.any?
      x,y = stack.pop
      next if visited[y][x] != -1

      visited[y][x] = 1
      pt = nums[y][x]
      basins.last << pt

      up, down = nums[y-1][x], nums[y+1][x]
      left, right = nums[y][x-1], nums[y][x+1]

      stack << [x, y-1] if up < 9 && up > pt
      stack << [x, y+1] if down < 9 && down > pt
      stack << [x-1, y] if left < 9 && left > pt
      stack << [x+1, y] if right < 9 && right > pt
    end
    i += 1
  end

  ans_2 = basins.map { |x| x.count }.max(3).reduce(:*)
  pp "part 2: #{ans_2}"
end

solution(input)


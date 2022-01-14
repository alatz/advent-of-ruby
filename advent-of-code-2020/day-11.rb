require 'set'
require 'pp'

path = File.expand_path('input/input11.txt')
input = File.read(path).split("\n").map(&:chars)

def solution1(input)
  input = Marshal.load(Marshal.dump(input))
  res = -1
  x_max = input.first.size-1
  y_max = input.size-1

  while true 
    change_occupied = []
    change_leave = []
    prev = Marshal.dump(input)
    input.each_with_index { |r, ridx|
      r.each_with_index { |c, cidx|
        x = cidx
        y = ridx
        c1 = x > 0 && input[y][x-1] == "#" #left
        c2 = x < x_max && input[y][x+1] == "#" #right
        c3 = y < y_max && input[y+1][x] == "#" #down
        c4 = y > 0 && input[y-1][x] == "#"# up
        c5 = y > 0 && x > 0 && input[y-1][x-1] == "#" #up-left
        c6 = y > 0 && x < x_max && input[y-1][x+1] == "#" #up-right
        c7 = x > 0 && y < y_max && input[y+1][x-1] == "#" #down-left
        c8 = x < x_max && y < y_max && input[y+1][x+1] == "#" #down-right

        should_change = !(c1 || c2 || c3 || c4 || c5 || c6 || c7 || c8)
        change_occupied << [y,x] if input[y][x] == "L" && should_change

        if input[y][x] == "#"
          adj = 0
          adj += 1 if c1; adj += 1 if c2; adj += 1 if c3; adj += 1 if c4
          adj += 1 if c5; adj += 1 if c6; adj += 1 if c7; adj += 1 if c8
          change_leave << [y,x] if adj >= 4
        end
      }
    }

    change_occupied.each { |el| input[el[0]][el[1]] = "#" }
    change_leave.each { |el| input[el[0]][el[1]] = "L" }

    if Marshal.dump(input) == prev
      res = input.join.count("#")
      break
    end
  end

  res
end

def solution2(input)
  input = Marshal.load(Marshal.dump(input))
  res = -1
  x_max = input.first.size-1
  y_max = input.size-1

  while true 
    change_occupied = []
    change_leave = []
    prev = Marshal.dump(input)
    input.each_with_index { |r, ridx|
      r.each_with_index { |c, cidx|
        x, y = cidx, ridx
        c1, c2, c3, c4 = false, false, false, false
        c5, c6, c7, c8 = false, false, false, false

        i = 1
        while x-i >= 0 #left
          break if input[y][x-i] == "L"
          (c1 = true; break) if input[y][x-i] == "#"
          i += 1
        end
        i = 1
        while x+i <= x_max #right
          break if input[y][x+i] == "L"
          (c2 = true; break) if input[y][x+i] == "#"
          i += 1
        end
        i = 1
        while y+i <= y_max #down
          break if input[y+i][x] == "L"
          (c3 = true; break) if input[y+i][x] == "#"
          i += 1
        end
        i = 1
        while y-i >= 0 #up
          break if input[y-i][x] == "L"
          (c4 = true; break) if input[y-i][x] == "#"
          i += 1
        end
        i = 1
        while y-i >= 0 && x-i >= 0 #up-left
          break if input[y-i][x-i] == "L" 
          (c5 = true; break) if input[y-i][x-i] == "#"
          i += 1
        end
        i = 1
        while y-i >= 0 && x+i <= x_max #up-right
          break if input[y-i][x+i] == "L"
          (c6 = true; break) if input[y-i][x+i] == "#"
          i += 1
        end
        i = 1
        while y+i <= y_max && x-i >= 0 #down-left
          break if input[y+i][x-i] == "L"
          (c7 = true; break) if input[y+i][x-i] == "#"
          i += 1
        end
        i = 1
        while y+i <= y_max && x+i <= x_max
          break if input[y+i][x+i] == "L" #down-right
          (c8 = true; break) if input[y+i][x+i] == "#" #down-right
          i += 1
        end

        should_change = !(c1 || c2 || c3 || c4 || c5 || c6 || c7 || c8)
        change_occupied << [y,x] if input[y][x] == "L" && should_change

        if input[y][x] == "#"
          adj = 0
          adj += 1 if c1; adj += 1 if c2; adj += 1 if c3; adj += 1 if c4
          adj += 1 if c5; adj += 1 if c6; adj += 1 if c7; adj += 1 if c8
          change_leave << [y,x] if adj >= 5
        end
      }
    }

    change_occupied.each { |el| input[el.first][el.last] = "#" }
    change_leave.each { |el| input[el.first][el.last] = "L" }

    if Marshal.dump(input) == prev
      res = input.join.count("#")
      break
    end
  end

  res
end

pp solution1 input
pp solution2 input


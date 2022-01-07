# nmap <leader>t :!clear && ruby --disable=gems %<cr>

require 'set'
require 'pp'

path = File.expand_path('input/input03.txt')
input = File.read(path).split("\n")


# from Jonathan Paulson
def calc_slope(input, right, down)
    trees = 0
    x = 0
    y = 0
    while y+1 < input.size
        y += down
        x += right
        if input[y][x % input[y].size] == '#'
            trees += 1 
        end
    end
    trees
end


def solution1(input)
    max_x = input[0].size
    trees = 0
    x = 0
    input.each_index { |y|
        trees += 1 if input[y][x] == '#'
        x = (x + 3) % max_x
    }
    trees
end

def calc_slope(input, right, down)
    max_x = input[0].size
    trees = 0
    x = 0
    y = 0
    while y < input.size
        trees += 1 if input[y][x] == ?#
        x = (x + right) % max_x
        y += down
    end
    trees
end

def solution1(input)
    calc_slope(input, 3, 1)
end


def solution2(input)
    [[1,1], [3,1], [5,1], [7,1], [1,2]].map { |x|
        calc_slope(input, x[0], x[1])
    }.reduce(&:*)
end

pp solution1 input
pp solution2 input


















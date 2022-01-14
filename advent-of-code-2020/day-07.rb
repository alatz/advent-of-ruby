require 'set'
require 'pp'

path = File.expand_path('input/input07.txt')
input = File.read(path).split("\n")

def solution1(input)
  mat = []
  matches = {}
  matches["shiny gold"] = 1
  while true
    start_matches_size = matches.size
    input.each { |line|
      matches.each { |match, _|
        if line.match(/\s#{match}/)
          m = line.match(/^(\w+ \w+)/)
          mat << m[1]
        end
      }
    }
    mat.each { |m| matches[m] = 1 }
    break if start_matches_size == matches.size
  end

  matches.size - 1
end

def solution2(input)
  stack = [["1", "shiny gold"]]
  lookup = Hash.new
  count = 0 
  input.each { |line|
    contents = line.scan(/(\d) (\w+ \w+)/)
    lookup[line.match(/^(\w+ \w+)/).captures.first] = contents
  }
  while !stack.empty?
    bag = stack.pop
    interior_bags = lookup[bag[1]]
    interior_bags.each { |el|
      number_of_bags = el[0].to_i
      number_of_bags.times { stack << el }
    }
    count += 1
  end

  count-1
end

pp solution1 input
pp solution2 input


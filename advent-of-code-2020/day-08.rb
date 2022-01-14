require 'set'
require 'pp'

path = File.expand_path('input/input08.txt')
input = File.read(path).split("\n")
  .map { |ln| a = ln.split; [a[0], a[1].to_i] }

def solution1(input)
  visited = Hash.new { |h, k| h[k] = 0 }
  acc = 0
  pos = 0
  while true
    command = input[pos][0]
    arg = input[pos][1]
    visited[pos] += 1

    break if visited[pos] > 1

    case command
    when "acc"
      acc += arg
      pos += 1
    when "jmp"
      pos += arg
    when "nop"
      pos += 1
    end
  end

  acc
end

def solution2(input)
  jumps, nops = {}, {}
  input.each_with_index { |ln, i|
    jumps[i] = ln if ln[0] == "jmp"
    nops[i] = ln if ln[0] == "nop"
  }
  run = -> (positions, substitute_cmd) {
    positions.each { |key, v|
      acc = 0
      pos = 0
      visited = Hash.new { |h, k| h[k] = 0 }
      while true
        return acc if pos >= input.size

        command = input[pos][0]
        arg = input[pos][1]
        command = substitute_cmd if pos == key
        visited[pos] += 1

        break if visited[pos] > 1

        case command
        when "acc"
          acc += arg
          pos += 1
        when "jmp"
          pos += arg
        when "nop"
          pos += 1
        end
      end
    }
    nil
  }

  [run.call(nops, "jmp"), run.call(jumps, "nop")].compact.first
end

pp solution1 input
pp solution2 input


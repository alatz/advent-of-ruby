require 'set'
require 'pp'

path = File.expand_path('input/input25.txt')
input = File.read(path).split("\n").map(&:to_i)

def solution1(input)
  card_pk, door_pk = input

  acc, card_loop_size = 1, 0
  while acc != card_pk
    card_loop_size += 1
    acc *= 7
    acc %= 20201227
  end

  acc, i = 1, 1
  while i <= card_loop_size
    acc *= door_pk
    acc %= 20201227
    i += 1
  end

  acc
end

def solution2(input)
  # todo
end

pp solution1 input
pp solution2 input


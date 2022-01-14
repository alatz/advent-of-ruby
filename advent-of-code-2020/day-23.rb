require 'set'
require 'pp'

path = File.expand_path('input/input23.txt')
input = File.read(path).split("\n").first.chars.map(&:to_i)

class Node
  attr_accessor :val, :next
  def initialize(val) @val = val end
end

def solution1(input)
  nodes = input.map { |n| Node.new(n) }
  (nodes.size-1).times { |i| nodes[i].next = nodes[i+1] }
  nodes.last.next = nodes.first

  sorted = input.sort.reverse
  curr = nodes.first
  i = 0
  while i < 100
    picked_up_cups = [curr.next.val, curr.next.next.val, curr.next.next.next.val]
    candidate_cups = sorted - picked_up_cups
    idx = candidate_cups.bsearch_index { |x| (x <=> curr.val) }
    dest_cup_val = candidate_cups[(idx+1) % candidate_cups.size]

    traverser = curr
    while traverser.val != dest_cup_val
      traverser = traverser.next
    end

    # find the last of the three picked up cups
    last_of_the_three = curr.next.next.next

    # save the element to the right of the three for later
    one_to_the_right = last_of_the_three.next

    # set the last of the three cups to point to what the dest cup pointed to
    last_of_the_three.next = traverser.next

    # point dest cup towards the three cups that were picked up
    traverser.next = curr.next

    # point the current cup to the saved element to the right of the three
    curr.next = one_to_the_right

    curr = curr.next
    i += 1
  end

  # find 1
  curr = curr.next while curr.val != 1

  # increment to just after 1
  curr = curr.next

  res = []
  while curr.val != 1
    res << curr.val
    curr = curr.next
  end

  res.join.to_i
end

def solution2(input)
  # todo
end

pp solution1 input
pp solution2 input


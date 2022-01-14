require 'set'
require 'pp'

path = File.expand_path('input/input14.txt')
input = File.read(path).split("\n")
  .map { |x| x.sub('mask = ', '-') }
  .map { |x| '--' + x }.join.split('---')
  .map { |x| x.split('--') }
  .map { |x| x.map{ |y| 
    m = y.match(/mem\[(\d+)\] = (\d+)/)
    (m != nil) ? [m[1].to_i, m[2].to_i] : y
  }
}

#input = [
  #["XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X", [8, 11], [7, 101], [8, 0]] 
#]
#input = [
    #["000000000000000000000000000000X1001X", [42, 100]],
    #["00000000000000000000000000000000X0XX", [26, 1]],
#]

def solution1(input)
  mem = {}
  input.each { |inst|
    mask = inst.first 
    inst.drop(1).each { |vals|
      loc, num = vals
      num = num.to_s(2)
      num = "0" + num while num.size < mask.chars.size
      mask.chars.each_with_index { |c, i| num[i] = c if c != "X" }
      mem[loc] = num
    }
  }
  mem.values.map { |x| x.to_i(2) }.reduce(&:+) 
end

def solution2(input)
  mem = {}
  input.each { |inst|
    mask = inst.first 

    inst.drop(1).each { |vals|
      loc, num = vals
      loc = loc.to_s(2)

      loc.prepend("0") while loc.size < mask.chars.size
      mask.chars.each_with_index { |c, i| loc[i] = c if c != "0" }

      done = []
      locs = [loc]
      while locs.any?
        el = locs.pop
        pushed = false
        if el.include?("X")
          locs << el.dup.sub("X", "1")
          locs << el.dup.sub("X", "0")
          pushed = true
        end
        done << el if !pushed
      end

      done.each { |x| mem[x] = num }
    }
  }

  mem.values.reduce(&:+) 
end

pp solution1 input
pp solution2 input


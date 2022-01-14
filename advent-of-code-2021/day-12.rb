require 'set'
require 'pp'

path = File.expand_path('input/input12.txt')
input = File.read(path).split("\n")

def solution(paths, pt = 1)
  paths = paths.map { |x| x.split("-") }
  ans = 0
  hash = Hash.new { |h,k| h[k] = [] }
  paths.each { |p|
    a, b = p
    hash[a] << b if b != 'start'
    hash[b] << a if a != 'start'
  }
  stack = []
  hash['start'].each { |e| stack << ['start', e, Set.new] }

  while stack.any?
    *body, tail, s = stack.pop
    if tail == tail.downcase
      if pt == 2
        s.include?(tail) ? s.add("visit2") : s.add(tail)
      else 
        s.add(tail)
      end
    end

    hash[tail].each { |opt|
      if pt == 2
        next if s.include?(opt) && s.include?("visit2")
      else
        next if s.include?(opt)
      end

      if opt == 'end'
        ans += 1
        next
      else
        stack << body + [tail, opt, s.clone]
      end
    }
  end

  ans
end

pp "part 1: " + solution(input).to_s
pp "part 2: " + solution(input, 2).to_s


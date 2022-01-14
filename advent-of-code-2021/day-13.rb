require 'set'
require 'pp'

path = File.expand_path('input/input13.txt')
input = File.read(path).split("\n")

def solution(data)
  dots, folds = [], []
  data.each { |l|
    a = l.match(/(\d+),(\d+)/)
    b = l.match(/([x|y])=(\d+)/)
    dots << [a[1].to_i, a[2].to_i] if !a.nil?
    folds << [b[1], b[2].to_i] if !b.nil?
  }

  fold = 0
  while fold < folds.size
    a,n = folds[fold]
    res = []
    if a == "y"
      i = 0
      while i < dots.size
        dx,dy = dots[i]
        if dy < n
          res << [dx, dy]
        elsif dy != n
          yloc = n - (dy - n)
          res << [dx, yloc]
        end
        i += 1
      end
    elsif a == "x"
      i = 0
      while i < dots.size
        dx,dy = dots[i]
        if dx < n
          res << [dx, dy]
        elsif dx != n
          xloc = n - (dx - n)
          res << [xloc, dy]
        end
        i += 1
      end
    end

    dots = res.uniq

    pp "part 1: #{dots.size}" if fold == 0

    fold += 1
  end

  xmax = dots.map { |x,y| x }.max
  ymax = dots.map { |x,y| y }.max
  grid = Array.new(ymax+1) { Array.new(xmax+1, " ") }
  dots.each { |dot| grid[dot[1]][dot[0]] = "#" }

  pp "part 2:"
  grid.transpose.map { |x| x.reverse } # LRFJBJEH
end

pp solution(input)


require 'set'
require 'pp'

path = File.expand_path('input/input10.txt')
input = File.read(path).split("\n")

def solution(lines)
  incomplete_lines = []
  pt_1, pt_2 = 0, 0

  i = 0
  while i < lines.size
    while true
      run_again = false
      while lines[i].match(/\(\)/)
        lines[i] = lines[i].gsub(/\(\)/, "")
        run_again = true
      end

      while lines[i].match(/\[\]/)
        lines[i] = lines[i].gsub(/\[\]/, "")
        run_again = true
      end

      while lines[i].match(/\{\}/)
        lines[i] = lines[i].gsub(/\{\}/, "")
        run_again = true
      end

      while lines[i].match(/\<\>/)
        lines[i] = lines[i].gsub(/\<\>/, "")
        run_again = true
      end

      break if !run_again
    end

    ignore = ["]",")","}",">"].intersection(lines[i].chars).any?
    incomplete_lines << lines[i].reverse.chars if !ignore

    lines[i].chars.each { |c|
      if c == ")"
        pt_1 += 3
        break
      end
      if c == "]"
        pt_1 += 57
        break
      end
      if c == "}"
        pt_1 += 1197
        break
      end
      if c == ">"
        pt_1 += 25137
        break
      end
    }
    i += 1
  end

  scores = []
  incomplete_lines.each { |s|
    score = 0
    s.each { |c|
      score *= 5
      score += 1 if c == "("
      score += 2 if c == "["
      score += 3 if c == "{"
      score += 4 if c == "<"
    }
    scores << score
  }

  pt_2 = scores.sort[scores.size/2]

  pp "part 1: #{pt_1}"
  pp "part 2: #{pt_2}"
end

solution(input)


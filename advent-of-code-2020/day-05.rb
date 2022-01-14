require 'set'
require 'pp'

path = File.expand_path('input/input05.txt')
input = File.read(path).split("\n")

def solution(input)
  res = []
  input.each { |r|
    row_high, col_high = 127, 7
    row_low, col_low = 0, 0
    row_answer, col_answer = 0, 0
    r.chars.each { |c|
      row_mid = (row_high - row_low) / 2
      col_mid = (col_high - col_low) / 2
      case c
      when ?F
        row_answer = row_low if row_mid == 0
        row_high = row_high - row_mid - 1
      when ?B
        row_answer = row_high if row_mid == 0
        row_low = row_low + row_mid + 1
      when ?R
        col_answer = col_high if col_mid == 0 
        col_low = col_low + col_mid + 1
      when ?L
        col_answer = col_low if col_mid == 0 
        col_high = col_high - col_mid - 1
      end
    }
    res << (row_answer * 8) + col_answer
  }

  res = res.sort

  pp "part 1: #{res.max}"
  pp "part 2: #{((res.min..res.max).to_a - res).first}"
end

solution(input)


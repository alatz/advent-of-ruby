require 'set'
require 'pp'

path = File.expand_path('input/input08.txt')
input = File.read(path).split("\n")

def solution1(nums)
  digits = nums.map { |x| x.split("|") }.map { |x| x[1].strip }
  ans = 0
  digits.each { |d|
    d.scan(/\w+/).each { |s|
      ans += 1 if [2, 3, 4, 7].include?(s.size)
    }
  }

  ans
end


def solution2(nums)
  digits = nums.map { |x| x.split("|") }.map { |x| x[1].strip }
  signals = nums.map { |x| x.split("|") }.map { |x| x[0].strip }

  out = 0
  i = 0
  while i < signals.size
    hash = {}
    s = signals[i].split(" ")
    zero, one, two = "", "", ""
    three, four, five = "", "", ""
    six, seven, eight = "", "", ""
    nine = ""

    signals[i].scan(/\w+/).map { |y| 
      one = y if y.size == 2
      four = y if y.size == 4
      seven = y if y.size == 3
      eight = y if y.size == 7
    }

    # 1, 4, 7, 8 done
    s.delete(one)
    s.delete(four)
    s.delete(seven)
    s.delete(eight)

    s.each { |x|
      if x.size == 5
        three = x if x.include?(one[0]) && x.include?(one[1])
      end
    }

    # 3 done
    s.delete(three)

    s.each { |x|
      if x.chars.size == 6 
        diff = x.chars - three.chars
        nine = x.chars.join if diff.size == 1
      end
    }

    # 9 done
    s.delete(nine)

    s.each { |x|
      diff1 = eight.chars - x.chars 
      if diff1.size == 1
        diff2 = diff1 - one.chars
        zero = x if diff2.size == 1
        six = x if diff2.size == 0
      end
    }

    # 6, 7 done
    s.delete(six)
    s.delete(zero)

    s.each { |x|
      diff = six.chars - x.chars
      five = x if diff.size == 1
      two = x if diff.size == 2
    }

    hash = {
      zero => "0", one => "1", two => "2", three => "3",
      four => "4", five => "5", six => "6", seven => "7",
      eight => "8",
      nine => "9"
    }

    res = ""
    digits[i].split(" ").map(&:chars).each { |d|
      hash.keys.map(&:chars).each { |k|
        res += hash[k.join] if d.size == k.size && (d - k).size == 0
      }
    }

    out += res.to_i

    i += 1
  end

  out
end

pp solution1(input)
pp solution2(input)


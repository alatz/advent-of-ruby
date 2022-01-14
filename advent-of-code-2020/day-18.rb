require 'set'
require 'pp'

path = File.expand_path('input/input18.txt')
input = File.read(path).split("\n")

def solution1(input)
  sums = []
  input.each { |l|
    while l.match(/[\+|\*]/)
      while l.match(/\((\d+ [\+|\*] \d+).*\)/)
        l = l.gsub(/\((\d+ \* \d+)/) { |m| "(" + eval(m.sub("(", "")).to_s  }
        l = l.gsub(/\((\d+ \+ \d+)/) { |m| "(" + eval(m.sub("(", "")).to_s  }
      end
      while l.match(/^(\d+ [\+|\*] \d+)/)
        l = l.gsub(/^(\d+ [\+] \d+)/) { |m| eval(m) }
        l = l.gsub(/^(\d+ [\*] \d+)/) { |m| eval(m) }
      end
      while l.match(/\((\d+)\)/)
        l = l.gsub(/\((\d+)\)/) { |m| m.gsub(/[\(|\)]/, "") }
      end
    end

    sums << l.to_i
  }

  sums.reduce(&:+)
end


def solution2(input)
  sums = []
  input.each { |l|
    while l.match(/\+/)
      while l.match(/\((\d+ \* \d+)\)/)
        l = l.gsub(/\((\d+ \* \d+)\)/) { |m| 
          eval(m.gsub(/[\(|\)]/, "")) 
        }
      end
      while l.match(/\((\d+ \* \d+ \* \d+)\)/)
        l = l.gsub(/\((\d+ \* \d+ \* \d+)\)/) { |m|
          eval(m.gsub(/[\(|\)]/, "")) 
        }
      end
      while l.match(/\((\d+ \* \d+ \* \d+ \* \d+)\)/)
        l = l.gsub(/\((\d+ \* \d+ \* \d+ \* \d+)\)/) { |m|
          eval(m.gsub(/[\(|\)]/, "")) 
        }
      end
      while l.match(/\((\d+ \* \d+ \* \d+ \* \d+ \* \d+)\)/)
        l = l.gsub(/\((\d+ \* \d+ \* \d+ \* \d+ \* \d+)\)/) { |m|
          eval(m.gsub(/[\(|\)]/, "")) 
        }
      end
      while l.match(/\((\d+ \* \d+ \* \d+ \* \d+ \* \d+ \* \d+)\)/)
        l = l.gsub(/\((\d+ \* \d+ \* \d+ \* \d+ \* \d+ \* \d+)\)/) { |m| 
          eval(m.gsub(/[\(|\)]/, "")) 
        }
      end
      while l.match(/(\d+ \+ \d+)/)
        l = l.gsub(/(\d+ \+ \d+)/) { |m| eval(m)  }
        l = l.gsub(/\((\d+)\)/) { |m| m.sub("(", "").sub(")", ""); }
      end
    end

    sums << eval(l)
  }

  sums.reduce(&:+)
end

pp solution1 input
pp solution2 input


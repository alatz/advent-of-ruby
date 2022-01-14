require 'set'
require 'pp'

path = File.expand_path('input/input19.txt')
input = File.read(path).split("\n")

def solution1(input)
  msgs = []
  input.map { |l|
    m = l.match(/^(\w{5,})/)
    msgs << m[1] if m != nil 
  }

  rules = {}
  input.map { |l|
    m = l.match(/(\d+): (.*)/)
    rules[m[1]] = m[2].sub(" | ", "|").gsub(" ", ",")
      .split("|").map { |x| x.split(",") } if m != nil
  }

  str = "0"
  while str.match(/\d+/)
    m = str.match(/(\d+)/)
    if m != nil
      r = ""
      rules[m[1]].each_with_index { |x, idx|
        r += "|" if idx > 0
        r += x.join(',')
      }
      str = str.sub(m[1],"("+r+")")
    end
  end

  str = str.gsub(/\(a\)/,"a").gsub(/\(b\)/,"b")
  str = str.gsub(/,/,"")
  str = "^" + str + "$"

  ans = 0
  msgs.each { |msg| ans += 1 if msg.match(str) }

  ans
end

def solution2(input)
  msgs = []
  input.map { |l|
    m = l.match(/^(\w{5,})/)
    msgs << m[1] if m != nil 
  }

  rules = {}
  input.map { |l|
    m = l.match(/(\d+): (.*)/)
    rules[m[1]] = m[2].sub(" | ", "|").gsub(" ", ",")
      .split("|").map { |x| x.split(",") } if m != nil
  }

  rules["8"] = [["42"], ["42", "998"]]
  rules["11"] = [["42", "31"], ["42", "999", "31"]]
  rules["999"] = [["42", "31"], ["42", "997", "31"]]
  rules["998"] = [["42"], ["42", "996"]]
  rules["997"] = [["42", "31"], ["42", "995", "31"]]
  rules["996"] = [["42"], ["42", "994"]]
  rules["995"] = [["42", "31"], ["42", "993", "31"]]
  rules["994"] = [["42"], ["42", "992"]]
  rules["993"] = [["42", "31"], ["42", "31"]]
  rules["992"] = [["42"], ["42"]]

  str = "0"
  while str.match(/\d+/)
    m = str.match(/(\d+)/)
    if m != nil
      r = ""
      rules[m[1]].each_with_index { |x, idx|
        r += "|" if idx > 0
        r += x.join(',')
      }
      str = str.sub(m[1],"("+r+")")
    end
  end

  str = str.gsub(/\(a\)/,"a").gsub(/\(b\)/,"b")
  str = str.gsub(/,/,"")
  str = "^" + str + "$"

  ans = 0
  msgs.each { |msg| ans += 1 if msg.match(str) }

  ans
end

pp solution1 input
pp solution2 input


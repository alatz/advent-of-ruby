require 'set'
require 'pp'

path = File.expand_path('input/input03.txt')
input = File.read(path).split("\n")

#test_input = [ 
  #"00100", "11110", "10110", "10111", "10101", "01111",
  #"00111", "11100", "10000", "11001", "00010", "01010", 
#]

def solution1(data)
  a, b, c, d, e, f = 0, 0, 0, 0, 0, 0
  g, h, x, j, k, l = 0, 0, 0, 0, 0, 0

  i = 0
  while i < data.size
    a += data[i][0].to_i
    b += data[i][1].to_i
    c += data[i][2].to_i
    d += data[i][3].to_i
    e += data[i][4].to_i
    f += data[i][5].to_i
    g += data[i][6].to_i
    h += data[i][7].to_i
    x += data[i][8].to_i
    j += data[i][9].to_i
    k += data[i][10].to_i
    l += data[i][11].to_i

    i += 1
  end

  r = ""
  fn = -> (x) { return (x > data.size / 2) ? "1" : "0" }

  r += fn.(a)
  r += fn.(b)
  r += fn.(c)
  r += fn.(d)
  r += fn.(e)
  r += fn.(f)
  r += fn.(g)
  r += fn.(h)
  r += fn.(x)
  r += fn.(j)
  r += fn.(k)
  r += fn.(l)

  epsilon = r.tr("01","10").to_i(2)
  gamma = r.to_i(2)

  gamma * epsilon
end

def solution2(data)
  len = data[1].size
  d1 = Marshal.load(Marshal.dump(data))

  g_idx = 0
  while true
    ct = 0
    keep = []
    d1.each_with_index { |obj, k| ct += obj[g_idx].to_i }
    comparison = (ct >= (d1.size - ct)) ? "1" : "0"
    d1.each_with_index { |obj, k| 
      keep << obj if obj[g_idx] == comparison
    }
    d1 = keep
    g_idx += 1
    break if d1.size == 1 || g_idx >= len
  end


  d2 = Marshal.load(Marshal.dump(data))
  g_idx = 0
  while true
    ct = 0
    keep = []
    d2.each_with_index { |obj, k| ct += obj[g_idx].to_i }
    comparison = (ct >= (d2.size - ct)) ? "0" : "1"
    d2.each_with_index { |obj, k| 
      keep << obj if obj[g_idx] == comparison
    }
    d2 = keep
    g_idx += 1
    break if d2.size == 1 || g_idx >= len
  end

  ox_rating = d1.first.to_i(2)
  scrub_rating = d2.first.to_i(2)

  ox_rating * scrub_rating
end

pp solution1(input)
pp solution2(input)


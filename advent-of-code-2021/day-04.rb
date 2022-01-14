require 'set'
require 'pp'

path = File.expand_path('input/input04.txt')
input = File.read(path).split("\n").map { |x| x.split(" ") }

input[0] = input[0][0].split(",")
input << []

def solution1(data)
  draw_nums = data[0]

  i = 1
  boards, g = [], []
  while i < data.size
    if data[i] == []
      boards << g
      g = []
    else
      g << data[i]
    end
    i += 1
  end

  winning_sets = []
  i = 0
  while i < boards.size
    j = 0
    temp = []
    while j < 5
      temp << boards[i][j].to_set
      j += 1
    end

    b = boards[i].transpose

    j = 0
    while j < 5
      temp << b[j].to_set
      j += 1
    end

    winning_sets << temp
    i += 1
  end

  s = draw_nums[0..4].to_set
  i = 5
  while i < draw_nums.size
    s.add(draw_nums[i])

    j = 0
    while j < winning_sets.size
      k = 0
      while k < winning_sets[j].size
        combin = winning_sets[j][k]
        if combin.subset?(s)
          set = Set.new
          winning_sets[j][0..4].each { |x| set.add(x) }
          num = set.flatten.subtract(s).to_a.map(&:to_i).sum
          return num * draw_nums[i].to_i
        end
        k += 1
      end
      j += 1 
    end
    i += 1
  end
end

def solution2(data)
  draw_nums = data[0]
  i = 1
  boards, g = [], []
  while i < data.size
    if data[i] == []
      boards << g
      g = []
    else
      g << data[i]
    end
    i += 1
  end

  winning_sets = []
  i = 0
  while i < boards.size
    j = 0
    temp = []
    while j < 5
      temp << boards[i][j].to_set
      j += 1
    end

    b = boards[i].transpose

    j = 0
    while j < 5
      temp << b[j].to_set
      j += 1
    end

    winning_sets << temp
    i += 1
  end

  s = draw_nums[0..4].to_set
  res = []
  i = 5
  while i < draw_nums.size
    s.add(draw_nums[i])

    dup = Marshal.load(Marshal.dump(s))
    j = 0
    while j < winning_sets.size
      k = 0
      while k < winning_sets[j].size
        combin = winning_sets[j][k]
        res << [j, draw_nums[i], combin, dup] if combin.subset?(s)
        k += 1
      end
      j += 1 
    end
    i += 1
  end

  arr, h = {}, {}
  res.each { |x|
    arr = x if h.size == winning_sets.size-1 && !h.has_key?(x[0])
    h[x[0]] = true
  }

  set = Set.new
  winning_sets[arr[0]][..4].map { |x| set.add(x) }

  set.flatten.subtract(arr[3]).to_a.map(&:to_i).sum * arr[1].to_i
end

pp solution1(input)
pp solution2(input)


require 'set'
require 'pp'

path = File.expand_path('input/input16.txt')
input = File.read(path).split("\n")
  .map { |x| x == "" ? "--" : x + "--" }.join.split("----")
  .map { |x| x.split("--") }

def solution1(input)
  rules = input.first.map { |x|
    m = x.match(/(\d+)-(\d+).*?(\d+)-(\d+)$/)
    [[m[1].to_i, m[2].to_i], [m[3].to_i, m[4].to_i]]
  }

  valid_values = {}
  rules.each { |ranges|
    ranges.each { |set|
      min, max = set
      (min..max).each { |n| valid_values[n] = 1 }
    }
  }
  tag, *nearby = input.last
  fields = nearby.join(',').scan(/\d+/).map(&:to_i)

  fields.select { |x| valid_values[x] == nil }.reduce(:+)
end

def solution2(input)
  rules = input.first.map { |x|
    m = x.match(/(\d+)-(\d+).*?(\d+)-(\d+)$/)
    [[m[1].to_i, m[2].to_i], [m[3].to_i, m[4].to_i]]
  }

  valid_values = {}
  rules.each { |ranges|
    ranges.each { |set|
      (set[0]..set[1]).each { |n| valid_values[n] = 1 }
    }
  }

  tag, *nearby = input.last
  nearby = nearby.map { |x| x.split(",").map(&:to_i) }

  valid_tickets = []
  nearby.each { |ticket| 
    skip = false
    ticket.each { |val| skip = true if valid_values[val] == nil }
    valid_tickets << ticket unless skip
  }

  valid_values_per_rule = []
  rules.slice(0,1).each { |ranges|
    h = { "id" => ranges }
    ranges.each { |set| (set[0]..set[1]).each { |n| h[n] = 1 } }
    valid_values_per_rule << h
  }

  idx_count = Hash.new { |h, k| h[k] = 0 }
  idx_count["id"] = valid_values_per_rule.first["id"]
  valid_tickets.each { |ticket|
    ticket.each_with_index { |v, i|
      idx_count[i] += 1 if valid_values_per_rule.first[v] != nil
    }
  }
  idx_count = idx_count.select { |k, v| v != 189 }

  # price: 38-55 or 66-957                => index 0
  # arrival track: 48-293 or 303-966      => index 2
  # wagon: 42-473 or 488-973              => index 4
  # arrival station: 36-528 or 551-956    => index 11
  # 
  # departure location: 36-269 or 275-973 => index 16
  # departure station: 25-237 or 245-972  => index 14
  # departure platform: 34-576 or 586-967 => index 9
  # departure track: 48-199 or 206-959    => index 7
  # departure date: 31-172 or 194-962     => index 6
  # departure time: 34-448 or 454-955     => index 3

  departure_indexes = [3, 6, 7, 9, 14, 16]
  my_ticket = input[1][1].split(",").map(&:to_i)

  departure_indexes.map { |x| my_ticket[x] }.reduce(&:*)
end

pp solution1 input
pp solution2 input


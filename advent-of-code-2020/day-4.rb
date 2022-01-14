
require 'set'
require 'pp'

path = File.expand_path('input/input04.txt')
input = File.read(path).split("\n")
input = input.map { |x| x != "" ?  x + " " : x }
input = input.map { |x| x == "" ? "---" : x  } 
input = input.join.split("---").map { |x| x.split }

def solution1(input)
    valid = 0
    input.each { |row|
        check = []
        row.each { |col|
            key = col.match(/(\w+):/).captures.first
            next if key == "cid"
            check << key
        }
        valid += 1 if check.size == 7
    }
    valid
end

def solution2(input)
    valid = 0
    input.each { |row|
        check = []
        row.each { |col|
            key, val = col.match(/(\w+):(.*)/).captures
            case key
            when 'byr' 
                break if !val.match(/^\d{4}$/)
                break if val.to_i < 1920 || val.to_i > 2002
            when 'iyr'
                break if !val.match(/^\d{4}$/)
                break if val.to_i < 2010 || val.to_i > 2020
            when 'eyr'
                break if !val.match(/^\d{4}$/)
                break if val.to_i < 2020 || val.to_i > 2030
            when 'hgt'
                break if !val.match(/^\d+(cm|in)$/)
                if val.match(/(cm)$/)
                    num = val.match(/(^\d+)/).captures.first
                    break if num.to_i < 150 || num.to_i > 193
                end
                if val.match(/(in)$/)
                    num = val.match(/(^\d+)/).captures.first
                    break if num.to_i < 59 || num.to_i > 76
                end
            when 'hcl'
                break if !val.match(/^#[0-9a-f]{6}$/) 
            when 'ecl'
                break if !val.match(/amb|blu|brn|gry|grn|hzl|oth/)
            when 'pid'
                break if !val.match(/^\d{9}$/)
            when 'cid'
                next 
            end
            check << key
        }
        valid += 1 if check.size == 7
    }
    valid
end


pp solution1 input
pp solution2 input



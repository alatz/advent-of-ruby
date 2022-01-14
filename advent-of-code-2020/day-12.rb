require 'set'
require 'pp'

path = File.expand_path('input/input12.txt')
input = File.read(path).split("\n")
    .map { |l| m = l.match(/^(\w)(\d+)/); [m[1], m[2].to_i] }

#input = ["F10", "N3", "F7", "R90", "F11"]
#input = ["F10", "W10", "F7", "L90", "F11"]
#input = ["F10", "N3", "F7", "R90", "F11", "S55", "W13", "E22"]
#input = input.map { |l| m = l.match(/^(\w)(\d+)/); [m[1], m[2].to_i] }

def solution1(input)
    rotate = {
        "north" => {
            "R90" => "east", "R180" => "south", "R270" => "west",
            "L90" => "west", "L180" => "south", "L270" => "east"
        },
        "south" => {
            "R90" => "west", "R180" => "north", "R270" => "east",
            "L90" => "east", "L180" => "north", "L270" => "west"
        },
        "east" => {
            "R90" => "south", "R180" => "west", "R270" => "north",
            "L90" => "north", "L180" => "west", "L270" => "south"
        },
        "west" => {
            "R90" => "north", "R180" => "east", "R270" => "south",
            "L90" => "south", "L180" => "east", "L270" => "north"
        },
    }
    dir = { "N" => "north", "S" => "south", "E" => "east", "W" => "west" }
    h = { "north" => 0, "south" => 0, "east" => 0, "west" => 0 }
    face = "east"

    input.each { |ln|
        char, num = ln
        if %w(N S E W).include?(char)
            h[dir[char]] += num
        elsif %w(R L).include?(char)
            face = rotate[face][char+num.to_s]
        elsif char == ?F
            h[face] += num
        end
    }

    (h["east"]-h["west"]).abs + (h["north"]-h["south"]).abs 
end


def solution2(input)
    rotate = { 
        "R" => { 
            "east" => "south", "west" => "north",
            "north" => "east", "south" => "west" 
        },
        "L" => {
            "east" => "north", "west" => "south",
            "north" => "west", "south" => "east" 
        }
    }
    dir = { "N" => "north", "S" => "south", "E" => "east", "W" => "west" }
    sh = { "north" => 0, "south" => 0, "east" => 0, "west" => 0 }
    wp = { "north" => 1, "south" => 0, "east" => 10, "west" => 0 }

    input.each { |x|
        char = x[0]
        num = x[1]

        if %w(N S E W).include?(char)
            wp[dir[char]] += num
        elsif %w(R L).include?(char)
            (num / 90).times {
                tmp = wp.each_with_object({}) { |(k, v), a| a[k] = v }
                wp.keys.each { |k| wp[rotate[char][k]] = tmp[k] }
            }
        elsif char == ?F
            waypoint_x_pos = wp["east"] - wp["west"]
            key = waypoint_x_pos > 0 ? "east" : "west"
            sh[key] += num * waypoint_x_pos.abs

            waypoint_y_pos = wp["north"] - wp["south"]
            key = waypoint_y_pos > 0 ? "north" : "south"
            sh[key] += num * waypoint_y_pos.abs
        end
    }

    (sh["east"]-sh["west"]).abs + (sh["north"]-sh["south"]).abs 
end

pp solution1 input
pp solution2 input


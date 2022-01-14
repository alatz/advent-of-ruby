require 'set'
require 'pp'

path = File.expand_path('input/input17.txt')
input = File.read(path).split("\n").map(&:chars)

def solution1(input)
  grid = Array.new(30) { Array.new(30) { Array.new(30, ".") } }
  mid = grid.size / 2

  i = 0
  while i < input.size
    j = 0
    while j < input.size
      grid[mid][mid+i][mid+j] = input[i][j] 
      j += 1
    end
    i += 1
  end

  cycle = 0
  while cycle < 6
    to_inactive = []
    to_active = []
    iz = 1
    while iz < grid.size-1
      iy = 1
      while iy < grid.size-1
        ix = 1
        while ix < grid.size-1 # find active neighbors
          nc = 0

          nc += 1 if grid[iz][iy][ix+1] == "#" #r
          nc += 1 if grid[iz][iy+1][ix+1] == "#" #dr
          nc += 1 if grid[iz][iy+1][ix] == "#" #d
          nc += 1 if grid[iz][iy+1][ix-1] == "#" #dl
          nc += 1 if grid[iz][iy][ix-1] == "#" #l
          nc += 1 if grid[iz][iy-1][ix-1] == "#" #ul
          nc += 1 if grid[iz][iy-1][ix] == "#" #u
          nc += 1 if grid[iz][iy-1][ix+1] == "#" #ur
          nc += 1 if grid[iz-1][iy][ix] == "#" #c
          nc += 1 if grid[iz-1][iy][ix+1] == "#" #r
          nc += 1 if grid[iz-1][iy+1][ix+1] == "#" #dr
          nc += 1 if grid[iz-1][iy+1][ix] == "#" #d
          nc += 1 if grid[iz-1][iy+1][ix-1] == "#" #dl
          nc += 1 if grid[iz-1][iy][ix-1] == "#" #l
          nc += 1 if grid[iz-1][iy-1][ix-1] == "#" #ul
          nc += 1 if grid[iz-1][iy-1][ix] == "#" #u
          nc += 1 if grid[iz-1][iy-1][ix+1] == "#" #ur
          nc += 1 if grid[iz+1][iy][ix] == "#" #c
          nc += 1 if grid[iz+1][iy][ix+1] == "#" #r
          nc += 1 if grid[iz+1][iy+1][ix+1] == "#" #dr
          nc += 1 if grid[iz+1][iy+1][ix] == "#" #d
          nc += 1 if grid[iz+1][iy+1][ix-1] == "#" #dl
          nc += 1 if grid[iz+1][iy][ix-1] == "#" #l
          nc += 1 if grid[iz+1][iy-1][ix-1] == "#" #ul
          nc += 1 if grid[iz+1][iy-1][ix] == "#" #u
          nc += 1 if grid[iz+1][iy-1][ix+1] == "#" #ur

          # active and exactly 2 or 3 neighbors are also active => remains active
          if grid[iz][iy][ix] == "#"
            to_inactive << [iz, iy, ix] if !(nc == 2 || nc == 3)
          end

          # inactive but exactly 3 neighbors are active => becomes active
          to_active << [iz, iy, ix] if grid[iz][iy][ix] == "." && nc == 3

          ix += 1
        end
        iy += 1
      end
      iz += 1
    end

    to_inactive.each { |p|
      z, y, x = p[0], p[1], p[2]
      grid[z][y][x] = "."
    }

    to_active.each { |p|
      z, y, x = p[0], p[1], p[2]
      grid[z][y][x] = "#"
    }

    cycle += 1
  end

  grid.flatten.count("#")
end


def solution2(input)
  grid = Array.new(25) { Array.new(25) { Array.new(25) { Array.new(25, ".") } } }
  mid = grid.size / 2

  i = 0
  while i < input.size
    j = 0
    while j < input.size
      grid[mid][mid][mid+i][mid+j] = input[i][j] 
      j += 1
    end
    i += 1
  end

  cycle = 0
  while cycle < 6
    to_inactive = []
    to_active = []

    iw = 1
    while iw < grid.size-1
      iz = 1
      while iz < grid.size-1
        iy = 1
        while iy < grid.size-1
          ix = 1
          while ix < grid.size-1 # find active neighbors
            nc = 0

            nc += 1 if grid[iw][iz][iy][ix+1] == "#" #r
            nc += 1 if grid[iw][iz][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw][iz][iy+1][ix] == "#" #d
            nc += 1 if grid[iw][iz][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw][iz][iy][ix-1] == "#" #l
            nc += 1 if grid[iw][iz][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw][iz][iy-1][ix] == "#" #u
            nc += 1 if grid[iw][iz][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw][iz-1][iy][ix] == "#" #c
            nc += 1 if grid[iw][iz-1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw][iz-1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw][iz-1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw][iz-1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw][iz-1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw][iz-1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw][iz-1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw][iz-1][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw][iz+1][iy][ix] == "#" #c
            nc += 1 if grid[iw][iz+1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw][iz+1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw][iz+1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw][iz+1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw][iz+1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw][iz+1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw][iz+1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw][iz+1][iy-1][ix+1] == "#" #ur

            nc += 1 if grid[iw+1][iz][iy][ix] == "#" #c
            nc += 1 if grid[iw+1][iz][iy][ix+1] == "#" #r
            nc += 1 if grid[iw+1][iz][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw+1][iz][iy+1][ix] == "#" #d
            nc += 1 if grid[iw+1][iz][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw+1][iz][iy][ix-1] == "#" #l
            nc += 1 if grid[iw+1][iz][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw+1][iz][iy-1][ix] == "#" #u
            nc += 1 if grid[iw+1][iz][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw+1][iz-1][iy][ix] == "#" #c
            nc += 1 if grid[iw+1][iz-1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw+1][iz-1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw+1][iz-1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw+1][iz-1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw+1][iz-1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw+1][iz-1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw+1][iz-1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw+1][iz-1][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw+1][iz+1][iy][ix] == "#" #c
            nc += 1 if grid[iw+1][iz+1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw+1][iz+1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw+1][iz+1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw+1][iz+1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw+1][iz+1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw+1][iz+1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw+1][iz+1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw+1][iz+1][iy-1][ix+1] == "#" #ur

            nc += 1 if grid[iw-1][iz][iy][ix] == "#" #c
            nc += 1 if grid[iw-1][iz][iy][ix+1] == "#" #r
            nc += 1 if grid[iw-1][iz][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw-1][iz][iy+1][ix] == "#" #d
            nc += 1 if grid[iw-1][iz][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw-1][iz][iy][ix-1] == "#" #l
            nc += 1 if grid[iw-1][iz][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw-1][iz][iy-1][ix] == "#" #u
            nc += 1 if grid[iw-1][iz][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw-1][iz-1][iy][ix] == "#" #c
            nc += 1 if grid[iw-1][iz-1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw-1][iz-1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw-1][iz-1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw-1][iz-1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw-1][iz-1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw-1][iz-1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw-1][iz-1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw-1][iz-1][iy-1][ix+1] == "#" #ur
            nc += 1 if grid[iw-1][iz+1][iy][ix] == "#" #c
            nc += 1 if grid[iw-1][iz+1][iy][ix+1] == "#" #r
            nc += 1 if grid[iw-1][iz+1][iy+1][ix+1] == "#" #dr
            nc += 1 if grid[iw-1][iz+1][iy+1][ix] == "#" #d
            nc += 1 if grid[iw-1][iz+1][iy+1][ix-1] == "#" #dl
            nc += 1 if grid[iw-1][iz+1][iy][ix-1] == "#" #l
            nc += 1 if grid[iw-1][iz+1][iy-1][ix-1] == "#" #ul
            nc += 1 if grid[iw-1][iz+1][iy-1][ix] == "#" #u
            nc += 1 if grid[iw-1][iz+1][iy-1][ix+1] == "#" #ur

            # active and exactly 2 or 3 neighbors 
            # are also active => remains active
            if grid[iw][iz][iy][ix] == "#"
              to_inactive << [iw, iz, iy, ix] if !(nc == 2 || nc == 3)
            end

            # inactive but exactly 3 neighbors
            # are active => becomes active
            if grid[iw][iz][iy][ix] == "."
              to_active << [iw, iz, iy, ix] if nc == 3
            end
            ix += 1
          end
          iy += 1
        end
        iz += 1
      end
      iw += 1
    end

    to_inactive.each { |p|
      w, z, y, x = p[0], p[1], p[2], p[3]
      grid[w][z][y][x] = "."
    }

    to_active.each { |p|
      w, z, y, x = p[0], p[1], p[2], p[3]
      grid[w][z][y][x] = "#"
    }

    cycle += 1
  end

  grid.flatten.count("#")
end

pp solution1 input
pp solution2 input


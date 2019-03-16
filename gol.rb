# gol.rb

# Game of Life
#
# A version of John Conway's classic Game of Life, written in Ruby
#
# Author(s): Josh Weinmann

class Gol

  # class variable grid
  @@grid

  # constructor
  def initialize(x, y)
    width = x
    height = y
    @@grid = Array.new(height) {Array.new(width)}
  end

  # main method
  def main

  end

  def self.grid
    @@grid
  end

  # print_grid attempts to print an x height by y width grid
  def print_grid(x, y, grid)

    # create starting coordinates
    row = 0
    col = 0

    # row loop
    while row < x

      # col loop
      while col < y
        if grid[row][col] == 1
          print "X "
        else
          print "O "
        end
        col += 1
      end

      col = 0
      print "\n"
      row += 1
    end

    print "\n"
  end

  # mutate takes a grid and mutates that grid according to Conway's rules
  def mutate_grid(x, y, grid)

    # new array to temporarily store values
    new_grid = @@grid

    # create starting coordinates
    row = 0
    col = 0

    # row loop
    while row < x

      # col loop
      while col < y

        neighbors = get_neighbors(row, col, x, y, grid)

        # "living" cell
        if grid[row][col] == 1

          # less then 2 neighbors - dies
          if neighbors < 2
            new_grid[row][col] = 0

          # 2 or 3 neighbors - lives
          elsif neighbors == 2 || neighbors == 3
            new_grid[row][col] = 1

          # more than 3 neighbors - dies
          elsif neighbors > 3
            new_grid[row][col] = 0
          end

        # "dead" cell
        elsif grid[row][col] == 0

          # more than 3 neighbors - becomes alive
          if neighbors == 3
            new_grid[row][col] = 1
          end
        end

        col += 1
      end

      col = 0
      row += 1
    end

    @@grid = new_grid

  end

  # helper method to get number of live neighbors a cell has
  # @returns number of neighbors
  def get_neighbors(i, j, x, y, grid)

    count = 0

    # top left corner
    if i == 0 && j == 0

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # southeast
      if grid[i + 1][j + 1] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # top right corner
    elsif i == 0 && j == (y - 1)

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # southwest
      if grid[i + 1][j - 1]
        count += 1
      end

      # bottom left corner
    elsif i == (x - 1) && j == 0

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # northeast
      if grid[i - 1][j + 1] == 1
        count += 1
      end

      # bottom right corner
    elsif i == (x - 1) && j == (y - 1)

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # northwest
      if grid[i - 1][j - 1] == 1
        count += 1
      end

      # top
    elsif i == 0

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # southwest
      if grid[i + 1][j - 1]
        count += 1
      end

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # southeast
      if grid[i + 1][j + 1] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # bottom
    elsif i == (x - 1)

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # northwest
      if grid[i - 1][j - 1] == 1
        count += 1
      end

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # northeast
      if grid[i - 1][j + 1] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # left
    elsif j == 0

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # northeast
      if grid[i - 1][j + 1] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # southeast
      if grid[i + 1][j + 1] == 1
        count += 1
      end

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # right
    elsif j == (y - 1)

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # northwest
      if grid[i - 1][j - 1] == 1
        count += 1
      end

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # southwest
      if grid[i + 1][j - 1]
        count += 1
      end

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # middle
    else

      # north
      if grid[i - 1][j] == 1
        count += 1
      end

      # northwest
      if grid[i - 1][j - 1] == 1
        count += 1
      end

      # west
      if grid[i][j - 1] == 1
        count += 1
      end

      # southwest
      if grid[i + 1][j - 1]
        count += 1
      end

      # south
      if grid[i + 1][j] == 1
        count += 1
      end

      # northeast
      if grid[i - 1][j + 1] == 1
        count += 1
      end

      # east
      if grid[i][j + 1] == 1
        count += 1
      end

      # southeast
      if grid[i + 1][j + 1] == 1
        count += 1
      end

    end

    return count
  end

  # read text file for starting grid
  def read_file(fname)

    # 2D array grid
    g = Array.new {Array.new}

    # height
    h = 0

    # width
    w = 0

    # counters for file
    count = 0
    row = 0
    col = 0

    # read file line-by-line into 2D array
    File.open(fname).each do |line|

      if count == 0
        h = line.to_i
      elsif count == 1
        w = line.to_i
        g = Array.new(h) {Array.new(w)}
      else

        g[row][col] = line.chomp

        if row < h
          col += 1
        end

        if col == w-1
          col = 0
          row += 1
        end

      end

      count += 1
    end
    puts h
    puts w
    print g

  end

  # write text file for current grid
  def write_file(fname)



  end

end

print "Input height: "
height = gets.to_i
print "Input width: "
width = gets.to_i
g = Gol.new(height, width)
g.print_grid(height, width, Gol.grid)
g.read_file("test.txt")
# gol.rb

# Game of Life
#
# A version of John Conway's classic Game of Life, written in Ruby
#
# Author(s): Josh Weinmann, Daniel Shamburger

class Gol

  # class variable grid
  @@grid

  # constructor
  def initialize

  end

  # main method
  def main

    print "Enter file name: "
    file = gets.chomp
    @@grid = read_file(file)
    x = @@grid.length
    y = @@grid[0].length

    print "Enter 'q' to quit, 'w' to write current grid to a file, or press enter for the next iteration.\n\n"
    puts "Starting grid:"

    print_grid(x, y, @@grid)

    # loop to run game
    running = true
    while running

      # get input
      input = gets.chomp

      # quit
      if input == 'q'
        running = false

        # write current grid to file
      elsif input == 'w'

        print "Input file name to write to: "
        file_name = gets.chomp
        write_file(file_name)
        print "\n"
        puts "File saved"
        running = false

        # continue with next iteration
      else
        mutate_grid(x, y, @@grid)
        print_grid(x, y, @@grid)
      end

    end

  end

  # getter for grid array
  def self.grid
    @@grid
  end

  # print_grid attempts to print an x height by y width grid
  # @params x = height, y = width, grid = grid array
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
          print ". "
        end
        col += 1
      end

      col = 0
      print "\n"
      row += 1
    end

  end

  # mutate takes a grid and mutates that grid according to Conway's rules
  # @params x = height, y = width, grid = grid array
  def mutate_grid(x, y, grid)

    # new array to temporarily store values
    new_grid = Marshal.load(Marshal.dump(grid))

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
  # @params i = row, j = col, x = height, y = width, grid = grid array
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
      if grid[i + 1][j - 1] == 1
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
      if grid[i + 1][j - 1] == 1
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
      if grid[i + 1][j - 1] == 1
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
      if grid[i + 1][j - 1] == 1
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
  # @params fname file name
  # @return grid array
  def read_file(fname)

    # 2D array grid
    grid = []

    File.open(fname) do |f|
      f.each_line do |line|
        grid << line.split.map(&:to_i)
      end
    end

    return grid

  end

  # write text file for current grid
  # @params fname file name
  def write_file(fname)

    File.open(fname, 'w') do |f|

      # create starting coordinates
      row = 0
      col = 0
      x = @@grid.length
      y = @@grid[0].length

      # row loop
      while row < x

        # col loop
        while col < y

          f.print(@@grid[row][col])
          f.print " "

          col += 1
        end

        col = 0
        f.print "\n"
        row += 1
      end

    end

  end

end

g = Gol.new
g.main
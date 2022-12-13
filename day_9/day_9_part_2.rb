require 'set'
input_file = ARGV[0]
moves = File.read(input_file).split("\n")

class Position
  attr_reader :x
  attr_reader :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def move_up
    @y += 1
  end

  def move_down
    @y -= 1
  end

  def move_left
    @x -= 1
  end

  def move_right
    @x += 1
  end

  def touching?(other)
    adjacent = (x - other.x).abs <= 1 && (y - other.y).abs <= 1
  end

  def to_s
    "{x: #{x}, y: #{y}}"
  end
end

class Grid
  
  def initialize
    @knots = 10.times.map { Position.new(0, 0)}
    @visited = Set[[0,0]]
  end

  def move_right
    @knots.first.move_right
    move_rest_of_knots
  end

  def move_left
    @knots.first.move_left
    move_rest_of_knots
  end

  def move_up
    @knots.first.move_up
    move_rest_of_knots
  end

  def move_down
    @knots.first.move_down
    move_rest_of_knots
  end

  def move_rest_of_knots
    Range.new(1, @knots.length - 1).each { |index| move_next_knot(index) }
  end

  def move_next_knot(current_knot_index)
    current_knot = @knots[current_knot_index]
    previous_knot = @knots[current_knot_index - 1]
    return if current_knot.touching?(previous_knot)
    if previous_knot.x == current_knot.x 
      if previous_knot.y > current_knot.y
        current_knot.move_up
      else
        current_knot.move_down
      end
    elsif previous_knot.y == current_knot.y
      if previous_knot.x > current_knot.x
        current_knot.move_right
      else
        current_knot.move_left
      end
    else
      if previous_knot.x > current_knot.x 
        current_knot.move_right
      else
        current_knot.move_left
      end
      if previous_knot.y > current_knot.y
        current_knot.move_up
      else
        current_knot.move_down
      end
    end
    @visited << [current_knot.x, current_knot.y] if current_knot_index == @knots.length - 1
  end

  def tail_visited
    @visited.length
  end
end

grid = Grid.new
moves.each do |move|
  direction, steps_str = move.split(" ")
  steps = steps_str.to_i
  case direction
  when "R"
    steps.times.each { grid.move_right }
  when "L"
    steps.times.each { grid.move_left }
  when "U"
    steps.times.each { grid.move_up }
  when "D"
    steps.times.each { grid.move_down }
  end
end
puts grid.tail_visited
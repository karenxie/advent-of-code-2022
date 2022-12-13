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
    @starting_position = Position.new(0, 0)
    @head  = Position.new(0, 0)
    @tail = Position.new(0, 0)
    @visited = Set[[0,0]]
  end

  def move_right
    @head.move_right
    move_tail
  end

  def move_left
    @head.move_left
    move_tail
  end

  def move_up
    @head.move_up
    move_tail
  end

  def move_down
    @head.move_down
    move_tail
  end

  def move_tail
    return if @tail.touching?(@head)
    if @head.x == @tail.x 
      if @head.y > @tail.y
        @tail.move_up
      else
        @tail.move_down
      end
    elsif @head.y == @tail.y
      if @head.x > @tail.x
        @tail.move_right
      else
        @tail.move_left
      end
    else
      if @head.x > @tail.x 
        @tail.move_right
      else
        @tail.move_left
      end
      if @head.y > @tail.y
        @tail.move_up
      else
        @tail.move_down
      end
    end
    @visited << [@tail.x, @tail.y]
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
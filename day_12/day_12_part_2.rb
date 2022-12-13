require 'matrix'

input_file = ARGV[0]
grid_lines = File.read(input_file).split("\n")

grid = grid_lines.map do |line|
  line.chars
end

end_position = Matrix[*grid].index("E")

class Node
  
  @nodes = []

  class << self
    include Enumerable

    attr_reader :nodes

    def [](position) 
      @nodes.find { |node| position == node.position }
    end

    def add(node)
      @nodes << node
    end
  end

  attr_reader :position
  attr_reader :height

  attr_accessor :distance
  attr_accessor :previous

  def initialize(position, height)
    @position = position
    @height = height.ord
    @distance = Float::INFINITY
    @previous = nil
  end

  def height=(height)
    @height = height.ord
  end
end

grid.each_with_index do |row, row_index|
  row.each_with_index do |value, col_index|
    height = "a" if value == "S"
    height = "z" if value == "E"
    Node.add(Node.new([row_index, col_index], height || value))
  end
end

Node[end_position].distance = 0

unvisited = Node.nodes.dup
while !unvisited.empty?
  node = unvisited.sort! { |a, b| a.distance <=> b.distance }.shift
  x, y = node.position
  neighbouring_positions = [
    [x - 1, y],
    [x, y - 1],
    [x, y + 1],
    [x + 1, y],
  ].filter do |position|
    position.first >= 0 && position[1] >= 0 &&
    unvisited.find { |u| u.position == position} &&
    !Node[position].nil? &&
    Node[position].height >= node.height - 1
  end
  neighbouring_positions.each do |n|
    neighbour = Node[n]
    if neighbour.distance > node.distance + 1
      neighbour.distance = node.distance + 1
      neighbour.previous = node
    end
  end
end

lowest_elevation_nodes = Node.nodes.filter { |node| node.height == "a".ord }

puts lowest_elevation_nodes.map(&:distance).min
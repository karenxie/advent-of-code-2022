input_file = ARGV[0]
input_lines = File.read(input_file).split("\n")

grid = []
input_lines.each do |line|
  grid << line.chars
end

def can_see_tree?(tree_height, other_trees)
  other_trees.empty? || other_trees.all? { |other_tree| other_tree < tree_height }
end

def viewing_distance(tree_height, other_trees)
  distance = other_trees.length
  other_trees.each_with_index do |other_tree, index| 
    return index + 1 if other_tree >= tree_height
  end
  return distance
end

scenic_score = grid.map.each_with_index do |row, row_index|
  row.map.each_with_index do |tree_height, column_index|
    trees_from_the_left = row.take(column_index).reverse
    trees_from_the_right = row.drop(column_index + 1)
    trees_from_the_top = (row_index-1).downto(0).map { |other_tree_row| grid[other_tree_row][column_index] }
    trees_from_the_bottom = (row_index+1).upto(input_lines.length - 1).map { |other_tree_row| grid[other_tree_row][column_index] }

    viewing_distance(tree_height, trees_from_the_left) * 
    viewing_distance(tree_height, trees_from_the_right) * 
    viewing_distance(tree_height, trees_from_the_top) * 
    viewing_distance(tree_height, trees_from_the_bottom)
  end
end.flatten.max
puts scenic_score
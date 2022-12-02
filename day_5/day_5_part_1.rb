input_file = ARGV[0]
stack, ops = File.read(input_file).split("\n\n")

*stack_lines, num_line = stack.split("\n")
stacks = num_line.split(" ").map do |stack_number|
  []
end

stack_lines.reverse.each do |line| 
  line.chars.each_slice(4).with_index do |slice, index| 
    crate = slice.join.strip
    stacks[index] << crate unless crate.empty?
  end
end

# move 1 from 2 to 1
operation_lines = ops.split("\n")

operation_lines.each do |line|
  _, count, _, from, _, to = line.split(' ')
  from_stack = from.to_i - 1
  to_stack = to.to_i - 1
  count.to_i.times do 
    stacks[to_stack].push(stacks[from_stack].pop)
  end
end

result = stacks.map(&:last).map do |item|
  item.delete("[").delete("]")
end.join

puts result
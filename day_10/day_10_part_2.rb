input_file = ARGV[0]
instructions = File.read(input_file).split("\n")

x = 1
signal_strengths = []
instructions.each do |instruction|
  split_instruction = instruction.split(" ")
  case split_instruction
  in ["addx", value_str]
    signal_strengths << x
    x += value_str.to_i
    signal_strengths << x
  in ["noop"]
    signal_strengths << x
  end
end

# rows = signal_strengths.each_slice(40).to_a


# rows.each_with_index do |row, row_index|
#   pixel_row = row.each_index.map do |index|
#     sprite_position_index = index == 0 && row_index == 0 ? 0 : index - 1
#     if Range.new(row[sprite_position_index] - 1, row[sprite_position_index] + 1).include?(index)
#       "#"
#     else 
#       "."
#     end
#   end.to_a
#   puts pixel_row.join
# end

puts signal_strengths.length
output = ""
Range.new(0, signal_strengths.length - 1).map do |index|
  sprite_position_index = index == 0 ? 0 : index - 1
  sprite = Range.new(signal_strengths[sprite_position_index] - 1, signal_strengths[sprite_position_index] + 1)
  if sprite.include?(index % 40)
    output << "#"
  else
    output << "."
  end
  if (index+1) % 40 == 0
    output << "\n"
  end
end

puts output

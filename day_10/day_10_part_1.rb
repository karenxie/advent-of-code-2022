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

aa = signal_strengths.each_with_index.map do |value, index|
  if ((index + 2) % 40) == 20
    value * (index + 2)
  end
end.compact.sum

puts aa
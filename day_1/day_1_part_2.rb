input_file = "input.txt"
input = File.read(input_file)
elves = input.split("\n\n")
calories = elves.map do |elf|
  elf.split("\n").map(&:to_i).sum
end.sort.reverse
puts calories.take(3).sum.inspect

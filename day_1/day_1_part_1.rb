# https://adventofcode.com/2022/day/1

input_file = "input.txt"
input = File.read(input_file)
elves = input.split("\n\n")
max_calories = 0
elves.each do |elf|
  total_calories = elf.split("\n").map(&:to_i).sum
  max_calories = total_calories if total_calories > max_calories
end
puts max_calories


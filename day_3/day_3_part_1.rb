
class Rucksack
  def initialize(contents)
    @first_compartment = contents.slice(0, contents.length/2).chars
    @second_compartment = contents.slice((contents.length/2), contents.length/2).chars
  end

  def find_common
    first_unique = @first_compartment.uniq
    second_unique = @second_compartment.uniq
    first_unique.map do |first|
      second_unique.map do |second|
        second if first == second
      end
    end.flatten.compact
  end
end

def priority(item)
  ascii_value = item.ord
  if ascii_value >= "A".ord && ascii_value <= "Z".ord
    ascii_value - 38
  elsif ascii_value >= "a".ord && ascii_value <= "z".ord
    ascii_value - 96
  end
end
input_file = "input.txt"
input = File.read(input_file)
rucksacks = input.split("\n").map { |line| Rucksack.new(line)}
common_items = rucksacks.map(&:find_common).flatten
puts common_items.map { |item| priority(item) }.sum

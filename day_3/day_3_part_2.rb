
class Group
  def initialize(first, second, third)
    @first = first.chars
    @second = second.chars
    @third = third.chars
  end

  def find_common
    @first.uniq.map do |first|
      @second.uniq.map do |second|
        @third.uniq.map do |third|
          first if first == second && second == third
        end.compact.flatten
      end
    end
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

input_file = ARGV[0]
lines = File.readlines(input_file).map(&:strip)
groups = input.each_slice(3).to_a.map { |group| Group.new(group[0], group[1], group[2])}
common_items = groups.map(&:find_common).flatten
puts common_items.map { |item| priority(item) }.sum

class Pair
  def initialize(input)
    elf_inputs = input.split(",")
    @first_elf = Elf.new(elf_inputs[0])
    @second_elf = Elf.new(elf_inputs[1])
  end

  def one_fully_contains_other?
    @first_elf.contains?(@second_elf) || @second_elf.contains?(@first_elf)
  end

  def to_s
    "#{@first_elf.to_s},#{@second_elf.to_s}"
  end
end

class Elf 
  attr_reader :start
  attr_reader :end

  def initialize(input)
    @start, @end = input.split("-").map(&:to_i)
  end

  def contains?(other_elf)
    @start <= other_elf.start && @end >= other_elf.end
  end

  def to_s
    "#{@start}-#{@end}"
  end
end

input_file = ARGV[0]
lines = File.readlines(input_file).map(&:strip)
pairs = lines.map { |line| Pair.new(line) }
# puts pairs.map(&:to_s).join("\n")
puts pairs.count(&:one_fully_contains_other?)

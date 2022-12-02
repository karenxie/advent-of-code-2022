class Pair
  def initialize(input)
    elf_inputs = input.split(",")
    @first_elf = Elf.new(elf_inputs[0])
    @second_elf = Elf.new(elf_inputs[1])
  end

  def overlaps?
    @first_elf.overlaps?(@second_elf)
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

  def overlaps?(other_elf)
    starts_in?(other_elf) || ends_in?(other_elf)
  end

  def to_s
    "#{@start}-#{@end}"
  end

  private 

  def starts_in?(other_elf)
    @start >= other_elf.start && @start <= other_elf.end
  end

  def ends_in?(other_elf)
    @end >= other_elf.start && @start <= other_elf.end
  end

end

input_file = ARGV[0]
lines = File.readlines(input_file).map(&:strip)
pairs = lines.map { |line| Pair.new(line) }
puts pairs.count(&:overlaps?)

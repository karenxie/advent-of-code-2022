input_file = ARGV[0]
monkey_input = File.read(input_file).split("\n\n")

class Monkey
  @monkeys = {}

  class << self
    include Enumerable

    def [](name) 
      @monkeys[name]
    end

    def each(&block)
      @monkeys.values.each(&block)
    end

    def add(str)
      monkey = Monkey.new(str)
      @monkeys[monkey.id] = monkey
    end

    
  end

  attr_reader :operation
  attr_reader :id
  attr_reader :inspected
  attr_reader :items

  def initialize(input)
    lines = input.split("\n").map(&:strip)
    id_line, items_line, operation_line, *test_lines = lines
    @id = id_line.split(" ").last[/\d+/].to_i
    @items = items_line.split(":").last.split(", ").map(&:strip).map(&:to_i)
    @operation = operation_from(operation_line.split(":").last.strip)
    @action = action_from(test_lines)
    @inspected = 0
  end

  def add(item)
    @items << item
  end

  def inspect_items
    @items.each do |item|
      @inspected += 1
      new_worry = @operation.call(item) / 3
      @action.call(new_worry, item)
    end

    @items = []
  end

  private

  def operation_from(str)
    _, right_side = str.split("=").map(&:strip)
    left, operator, right = right_side.split(" ")
    operation =
      case operator
      when "+"
        :+
      when "*"
        :*
      when "-"
        :-
      when "/"
        :/
      end
    
      lambda do |old|
        (left[/\d+/] ? left.to_i : old).public_send(operation, right[/\d+/] ? right.to_i : old)
      end
  end

  def action_from(test_lines)
    test, true_line, false_line = test_lines

    divisible_by = test[/\d+/].to_i
    lambda do |new_worry, old_worry|
      if new_worry % divisible_by == 0
        throw_to(new_worry, old_worry, true_line[/\d+/])
      else
        throw_to(new_worry, old_worry, false_line[/\d+/])
      end
    end
  end

  def throw_to(new_worry, old_worry, other_monkey)
    Monkey[other_monkey.to_i].add(new_worry)
  end
end

monkey_input.each do |input|
  Monkey.add(input)
end

20.times.each { Monkey.each { |monkey|  monkey.inspect_items } }

puts Monkey.each.map(&:inspected).max(2).reduce(:*)
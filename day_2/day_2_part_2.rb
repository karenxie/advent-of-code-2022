module Move
  def self.points
    raise "Not implemented"
  end

  def self.get_opponent_move(key)
    case key
    when "A"
      Rock
    when "B"
      Paper
    when "C"
      Scissors
    end
  end
end

class Rock
  include Move
  def self.points
    1
  end
end

class Paper
  include Move
  def self.points
    2
  end
end

class Scissors
  include Move
  def self.points
    3
  end
end

MOVES = [Rock, Paper, Scissors]

class Round
  attr_reader :your_move
  def initialize(opponent_move, outcome)
    @opponent_move = opponent_move
    @outcome = outcome
    @your_move = your_move
  end

  def your_move
    if @outcome == "Z"
      MOVES[(MOVES.find_index(@opponent_move) + 1) % 3]
    elsif @outcome == "Y"
      @opponent_move
    else
      MOVES[(MOVES.find_index(@opponent_move) - 1) % 3]
    end
  end
  def points
    if @outcome == "Z"
      6
    elsif @outcome == "Y"
      3
    else 
      0
    end
  end
end
input_file = "input.txt"
input = File.read(input_file)
rounds = input.split("\n").map do |round| 
  opponent, outcome = round.split(" ")
  Round.new(Move.get_opponent_move(opponent), outcome)
end
puts rounds.map { |round| round.points + round.your_move.points }.sum
module Move
  def self.points
    raise "Not implemented"
  end

  def self.beats
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

  def self.get_your_move(key)
    case key
    when "X"
      Rock
    when "Y"
      Paper
    when "Z"
      Scissors
    end
  end
end

class Rock
  include Move
  def self.points
    1
  end

  def self.beats
    Scissors
  end
end

class Paper
  include Move
  def self.points
    2
  end

  def self.beats
    Rock
  end
end

class Scissors
  include Move
  def self.points
    3
  end

  def self.beats
    Paper
  end
end

class Round
  attr_reader :your_move
  def initialize(opponent_move, your_move)
    @opponent_move = opponent_move
    @your_move = your_move
  end

  def points
    if @your_move.beats == @opponent_move
      6
    elsif @your_move == @opponent_move
      3
    else 
      0
    end
  end
end
input_file = "input.txt"
input = File.read(input_file)
rounds = input.split("\n").map do |round| 
  opponent, you = round.split(" ")
  Round.new(Move.get_opponent_move(opponent), Move.get_your_move(you))
end
puts rounds.map { |round| round.points + round.your_move.points }.sum
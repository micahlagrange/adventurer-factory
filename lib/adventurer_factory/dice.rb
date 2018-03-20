
module AdventurerFactory

  class ArgumentError < StandardError; end

  class Die
    attr_reader :value, :sides
    def initialize(sides)
      @sides = sides
      @value = roll
    end
    def > val
      @value > val
    end
    def < val
      @value < val
    end

    alias greater_than? >
    alias less_than? <
    
    private
    
    def roll
      1 + rand(@sides)
    end
  end

  module Dice
    def self.d20
      Die.new(20)
    end

    def self.advantage(die_type = :d20)
      bulk(2, die_type).max_by(&:value)
    end

    def self.disadvantage(die_type = :d20)
      bulk(2, die_type).min_by(&:value)
    end

    def self.bulk(count, die)
      raise ArgumentError.new("Count must be an integer") unless count.class == Fixnum
      raise ArgumentError.new("Die type must be a symbol such as :d6") unless die.class == Symbol
      raise ArgumentError.new("Die type must match /^d(\d+)$/") unless die =~ /^d(\d+)$/
      dice = []
      count.times do
        dice << send(die)
      end
      dice.each{|d| STDERR.print "..d#{d.sides}:#{d.value}" }
      return dice
    end

    def self.die_with_n_sides(n)
      Die.new(n)
    end

    def self.method_missing(meth, *args, &block)
      if meth =~ /^d\d+$/
        sides = meth.to_s.match(/^d(.*)$/)[1]
        return die_with_n_sides(sides.to_i)
      end
      super.method_missing(meth, *args, &block)
    end
  end
end


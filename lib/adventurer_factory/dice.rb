
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
    def greater_than? val
      @value > val
    end
    def less_than? val
      @value < val
    end
    
    private
    
    def roll
      1 + rand(@sides)
    end
  end

  module Dice
    def self.d20
      Die.new(20)
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

    def self.d(n)
      Die.new(n)
    end

    def self.method_missing(meth, *args, &block)
      if meth =~ /^d\d+$/
        sides = meth.to_s.match(/^d(.*)$/)[1]
        return d(sides.to_i)
      end
      super.method_missing(meth, *args, &block)
    end
  end
end


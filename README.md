# AdventureFactory
Helps guide you through the process of creating a DnD 5e character

# Dice module

AdventurerFactory::Dice exposes methods to roll one or more die of any number of sides.

A d(somenumber) (such as :d6, :d8, :d10, etc) method call returns a Die object with the specified number of sides and a random value in the range 1..sides

For example: 
```ruby
2.4.2 :001 > AdventurerFactory::Dice.d20
 => #<AdventurerFactory::Die:0x007fd8a0060808 @sides=20, @value=3>

2.4.2 :002 > AdventurerFactory::Dice.d6
 => #<AdventurerFactory::Die:0x007fd8a005bf38 @sides=6, @value=5>

2.4.2 :003 > AdventurerFactory::Dice.d100
 => #<AdventurerFactory::Die:0x007fd8a004c03b @sides=100, @value=42>
```

# Die objects

Respond to some plain Fixnum operations you might expect such as greater than, less than:
```ruby
2.4.2 :001 > require 'adventurer_factory/dice'
 => true 
2.4.2 :002 > die = AdventurerFactory::Dice.d7
 => #<AdventurerFactory::Die:0x007fd8a0058ef0 @sides=7, @value=6> 
2.4.2 :003 > die > 1
 => true 
2.4.2 :004 > die < 1
 => false 
```

As well as providing a method to simply get the value:
```ruby
2.4.2 :005 > die.value
 => 6 
```

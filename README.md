# AdventureFactory
Helps guide you through the process of creating a DnD 5e character

# Dice module

AdventurerFactory::Dice exposes methods to roll one or more die of any number of sides.

A d _somenumber_ method call returns a Die object with the specified number of sides and a random value in the range 1..sides

For example: 
```ruby
AdventurerFactory::Dice.d20
=> #<AdventurerFactory::Die:0x007fd8a0060808 @sides=20, @value=3>

AdventurerFactory::Dice.d6
=> #<AdventurerFactory::Die:0x007fd8a0060808 @sides=6, @value=5>

AdventurerFactory::Dice.d100
=> #<AdventurerFactory::Die:0x007fd8a0060808 @sides=100, @value=42>
```


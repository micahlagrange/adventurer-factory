# AdventureFactory
Helps guide you through the process of creating a DnD 5e character

# Starting the Rack server
```
$ rake server
Starting server: http://0.0.0.0:9001/
rackup -I ./lib --port 9001 --host 0.0.0.0 api/config.ru
/usr/lib/ruby/vendor_ruby/rake/file_utils.rb:82: warning: Insecure world writable dir /mnt/c in PATH, mode 040777
[2018-03-31 23:06:53] INFO  WEBrick 1.4.2
[2018-03-31 23:06:53] INFO  ruby 2.5.0 (2017-12-25) [x86_64-linux-gnu]
[2018-03-31 23:06:53] INFO  WEBrick::HTTPServer#start: pid=660 port=9001
```

### Specifying host/port/config.ru/library dir

```
$ rake server host=localhost port=8092 library=./lib rack_config=./api/config.ru
```

# Using the Api

Once you've started the server it will respond to the following paths:
`/dice/d20`
You can pass `d20`, `d10`,  or dice with any number of sides.
```json
{"sides":20,"value":6}
```

bulk operations:
`/dice/d20/3`
```json
[{"sides":20,"value":20},{"sides":20,"value":15},{"sides":20,"value":7}]
```

`/dice/d20/advantage`
rolls 2 dice and returns the higher one

`/dice/d20/disadvantage`
rolls 2 dice and returns the lower one


# Code library:
# Dice module

## Simple dice methods
`AdventurerFactory::Dice` exposes methods to roll one or more die of any number of sides.

A d(somenumber) (such as `:d6`, `:d8`, `:d10`, etc) method call returns a Die object with the specified number of sides and a random value in the range `1..sides`

For example: 
```ruby
AdventurerFactory::Dice.d20
 => #<AdventurerFactory::Die:0x007fd8a0060808 @sides=20, @value=3>

AdventurerFactory::Dice.d6
 => #<AdventurerFactory::Die:0x007fd8a005bf38 @sides=6, @value=5>

AdventurerFactory::Dice.d100
 => #<AdventurerFactory::Die:0x007fd8a004c03b @sides=100, @value=42>
```

## Die objects

Respond to some plain `Fixnum` operations you might expect such as greater than, less than:
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
die.value
 => 6 
```

## Bulk operations

Get a bunch of dice rolls of the same type all at once with AdventurerFactory::Dice.bulk

This returns an array of dice objects of the length you specify.
To get 3 10-sided dice for example:

```ruby

AdventurerFactory::Dice.bulk(3, :d10)
..d10:2..d10:2..d10:3 => [#<AdventurerFactory::Die:0x007fa9fc8cc320 @sides=10, @value=2>, #<AdventurerFactory::Die:0x007fa9fc8cc1e0 @sides=10, @value=2>, #<AdventurerFactory::Die:0x007fa9fc8cc0c8 @sides=10, @value=3>] 
```

For the moment, a summary of the dice goes to `stderr` just showing type and value.

Bulk operations are also used under the hood by the `.advantange` and `.disadvantage` module methods:

## Advantage, disadvantage

Roll 2 `:d20`, get the higher one:
```ruby
AdventurerFactory::Dice.advantage
 => #<AdventurerFactory::Die:0x007fd703853630 @sides=20, @value=19> 
```

Roll 2 `:d20` and get the lower:

```ruby
AdventurerFactory::Dice.disadvantage
 => #<AdventurerFactory::Die:0x007fd70404d4d0 @sides=20, @value=7> 
```

Advantage or disadvantage takes an optional symbol as an argument to generate dice with different numbers of sides:
```ruby
AdventurerFactory::Dice.advantage(:d10)
 => #<AdventurerFactory::Die:0x007fd70404d4d0 @sides=10, @value=7> 
```

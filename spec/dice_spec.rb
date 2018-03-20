require 'adventurer_factory/dice'

describe AdventurerFactory::Dice do
  subject { described_class }

  describe '.advantage' do
    context 'when no die type is given' do
      it 'rolls 2 dice and returns the higher one' do
        die = subject.advantage
        expect(die).to match AdventurerFactory::Die
      end
    end

    context 'when a die type is given' do
      it 'rolls 2 dice of the given type and returns the higher one' do
        die = subject.advantage(:d10)
        expect(die).to be_less_than 11
      end
    end
  end

  describe '.disadvantage' do
    it 'rolls 2 dice and returns the lower one' do
      die = subject.disadvantage
      expect(die).to match AdventurerFactory::Die
    end
  end

  describe '.d20' do
    it 'returns die object between 1 and 20' do
      expect(subject.d20.value.between?(1,20)).to be true
    end
  end

  describe '.bulk' do
    context 'when given a number of rolls to perform' do
      it 'returns n new die objects' do
        expect(subject.bulk(6,:d6)).to all( match AdventurerFactory::Die )
      end
    end
    context 'when nil is given' do
      it 'raises an argument error' do
        expect{subject.bulk(nil,nil)}.to raise_error AdventurerFactory::ArgumentError
      end
    end
  end

  describe '.method_missing' do
    [:d30, :d10, :d6, :d100000].each do |mth|
      context "when #{mth.to_s} is called" do
        sides = mth.to_s.match(/^d(.*)$/)[1]
        it "die object is less than #{sides.to_i + 1}" do
          expect(subject.send(mth)).to be_less_than (sides.to_i + 1)
        end
      end
    end
  end
end

describe AdventurerFactory::Die do
  subject { AdventurerFactory::Die.new(20) }
  describe '#>' do
    it 'it responds to >' do
      expect(subject > 0).to be true
    end
    it 'wont work' do
      expect(subject > 33).to be false
    end
  end
  describe '#<' do
    it 'it responds to <' do
      expect(subject < 99).to be true
    end
  end
end

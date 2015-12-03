require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  LIMIT = Oystercard::LIMIT
  MIN_FARE = Oystercard::MINIMUM_FARE

  context 'card WITHOUT money' do
    describe '#balance' do
      it 'returns balance as 0' do
        expect(oystercard.balance).to eq (0)
      end
    end
    describe '#top_up' do
      it 'adds cash to the oystercard' do
        expect { oystercard.top_up(10) }.to change{ oystercard.balance }.by 10
      end
      it 'prevents balance from exceeding £90' do
        over_90 = "Balance cannot exceed £#{LIMIT}"
        oystercard.top_up(90)
        expect {oystercard.top_up(1)}.to raise_error over_90
      end
    end
    describe '#touch_in' do
      it 'raises an error if balance is less than £1' do
        insufficient_funds = "Insufficient funds: Please add top up"
        expect{oystercard.touch_in(entry_station)}.to raise_error insufficient_funds
      end
    end
  end
  context 'card WITH money' do
    before do
      oystercard.top_up(LIMIT)
    end
    describe '#in_journey?' do
      it "should return false before touching in" do
        expect(oystercard).not_to be_in_journey
      end
      it 'should return true after touching in' do
        oystercard.touch_in(entry_station)
        expect(oystercard).to be_in_journey
      end
    end
    describe '#touch_out' do
      it 'should deduct the minimum fare' do
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -MIN_FARE
      end
      describe '#in_journey?' do
        it 'should return false' do
          oystercard.touch_in(entry_station)
          oystercard.touch_out(exit_station)
          expect(oystercard).not_to be_in_journey
        end
      end
    end
    describe '#history' do
      it 'is empty by default' do
        expect(oystercard.history).to eq ({})
      end
      it 'stores Journey history' do
        oystercard.touch_in("Brixton")
        oystercard.touch_out("Victoria")
        expect(oystercard.history).to eq ({J1: ["Brixton", "Victoria"]})
      end
      it 'stores multiple journeys in history' do
        oystercard.touch_in("Brixton")
        oystercard.touch_out("Victoria")
        oystercard.touch_in("Stockwell")
        oystercard.touch_out("Pimlico")
        expect(oystercard.history).to eq ({J1: ["Brixton", "Victoria"], J2: ["Stockwell", "Pimlico"]})
      end
    end
  end
end

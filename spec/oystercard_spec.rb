require 'oystercard'
describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
   describe '#balance' do
     it 'returns balance as 0' do
       expect(oystercard.balance).to eq (0)
     end
   end
 describe '#top_up' do

    it 'adds cash to the oystercard' do
      expect { oystercard.top_up(10) }.to change{ oystercard.balance }.by 10
    end
    it 'prevent balance from exceeding £90' do
      over_90 = "Balance cannot exceed £#{Oystercard::LIMIT}"
      oystercard.top_up(90)
      expect {oystercard.top_up(1)}.to raise_error over_90
    end
 end

 describe '#in_journey?' do

  it "Should return nil before touching in" do
    expect(oystercard).not_to be_in_journey
  end

  it 'Passing touch_in should change in Journey to true' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
  end
  it 'Passing touch_out should change in_Journey to false' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
  end
end
describe '#touch_in' do
  it 'Raise an error when touching in if balance is less than £1' do
    insufficient_funds = "Insufficient funds: Please add top up"
    expect{oystercard.touch_in(entry_station)}.to raise_error insufficient_funds
  end

end

describe '#touch_out' do
  it 'Should deduct the minimum fare on touch_out' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -Oystercard::MINIMUM_FARE
  end

end

describe '#history' do
  it 'history is emty by default' do
    expect(oystercard.history).to eq ({})
  end
  it 'stores Journey history' do
    oystercard.top_up(30)
    oystercard.touch_in("Brixton")
    oystercard.touch_out("Victoria")
    expect(oystercard.history).to eq ({J1: ["Brixton", "Victoria"]})
  end
  it 'Stores multiple journeys in history' do
    oystercard.top_up(30)
    oystercard.touch_in("Brixton")
    oystercard.touch_out("Victoria")
    oystercard.touch_in("Stockwell")
    oystercard.touch_out("Pimlico")
    expect(oystercard.history).to eq ({J1: ["Brixton", "Victoria"], J2: ["Stockwell", "Pimlico"]})
  end
end



end

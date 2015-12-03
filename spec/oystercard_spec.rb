require 'oystercard'
describe Oystercard do
  #oystercard = Oystercard.new
#let(:oystercard) { double :oystercard }
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
      oystercard.top_up(90)
      expect {oystercard.top_up(1)}.to raise_error "Balance cannot exceed £#{Oystercard::LIMIT}"
    end
 end

 describe '#in_journey?' do

  it "Should return nil before touching in" do
    #expect (oystercard.in_journey?).to be (false) why not work?
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
    expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds: Please add top up"
  end
  it 'should on touch_in record station' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    expect(oystercard.entry_station).to eq entry_station
  end

end

describe '#touch_out' do
  it 'Should deduct the minimum fare on touch_out' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -Oystercard::MINIMUM_FARE
  end
  it "Should record an exit station on touch_out" do
    oystercard.top_up(30)
    oystercard.touch_in("Brixton")
    oystercard.touch_out("Victoria")
    expect(oystercard.exit_station).to eq "Victoria"
  end
end


end

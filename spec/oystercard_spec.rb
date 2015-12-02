require 'oystercard'
describe Oystercard do
  #oystercard = Oystercard.new
#let(:oystercard) { double :oystercard }
  let(:oystercard) { described_class.new }
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

 describe '#deduct' do

   it 'deducts money' do
     expect { oystercard.deduct(10) }.to change{ oystercard.balance }.by -10
   end
 end

 describe '#in_journey?' do

  it "Should return nil before touching in" do
    #expect (oystercard.in_journey?).to be (false) why not work?
    expect(oystercard).not_to be_in_journey
  end

  it 'Passing touch_in should change in Journey to true' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end
  it 'Passing touch_out should change in_Journey to false' do
    oystercard.top_up(Oystercard::LIMIT)
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard).not_to be_in_journey
  end
end
describe '#touch_in' do
  it 'Raise an error when touching in if balance is less than £1' do
    expect{oystercard.touch_in}.to raise_error "Insufficient funds: Please add top up"
  end



end



end

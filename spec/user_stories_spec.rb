# In order to keep using public transport
# As a customer
# I want to add money to my card
#
#

#
# n order to get through the barriers
# As a customer
# I need to touch in and out
#

#
# In rder to pay for my journey
# As a customer
# I need to know where I've travelled from
#
# In oder to know where I have been
# As a customer
# I want to see to all my previous trips
#
# In orer to know how far I have travelled
# As a customer
# I want to know what zone a station is in
#
# In ordr to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
#
# In orde to be charged the correct amount
# As a customer
# I need to have the correct fare calculated
require 'oystercard'
describe 'User Story' do
  let(:oystercard) { Oystercard.new }
  it 'respond to balance' do
    expect { oystercard.balance }.not_to raise_error
  end

  it 'responds to top_up' do
    expect { oystercard.top_up(1) }.not_to raise_error
  end
  # In order to protect my money
 # As a customer
 # I don't want to put too much money on my card
 it 'prevents balance from exceeding £90' do
   max = Oystercard::LIMIT
   oystercard.top_up(max)
   expect {oystercard.top_up(1)}.to raise_error "Balance cannot exceed £#{Oystercard::LIMIT}"
 end
 #In order to pay for my journey
 # As a customer
 # I need my fare deducted from my card


 # n order to get through the barriers
 # As a customer
 # I need to touch in and out
it 'responds to in_journey' do
  expect { oystercard.in_journey? }.not_to raise_error
end



 it 'respond to touch_in' do
   oystercard.top_up(Oystercard::LIMIT)
    expect { oystercard.touch_in }.not_to raise_error
  end


  it 'respond to touch_out' do
     expect { oystercard.touch_out }.not_to raise_error
   end

   # I order to pay for my journey
   # As a customer
   # I need to have the minimum amount for a single journey

  #Inorder to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete



end

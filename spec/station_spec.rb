require 'station'

describe Station do
  subject(:station) { described_class.new('Brixton', '2') }

  describe 'initialize' do
    it 'creates a station with a name' do
      expect(station.name).to eq 'Brixton'
    end
    it 'creates a station with a zone' do
      expect(station.zone).to eq '2'
    end
  end
end

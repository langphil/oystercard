require 'station'

describe Station do
  subject(:station) { described_class.new("Kensington Olympia", 2) }

  describe 'station creation' do
    it 'should have a zone on initialize' do
      expect(station.station_name).to eq ('Kensington Olympia')
    end

    it 'should have a name on initialize' do
      expect(station.zone).to eq(2)
    end
  end
end

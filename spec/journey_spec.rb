require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station_one) { double(:station_one, :name => 'Victoria', :zone => 1) }
  let(:station_two) { double(:station_two, :name => 'Hammersmith', :zone => 1) }

  describe 'the creation of a new journey' do
    it 'a new journey to have an empty entry station' do
      expect(journey.entry_station).to eq nil
    end

    it 'a new journey to have an empty exit station' do
      expect(journey.exit_station).to eq nil
    end
  end
end

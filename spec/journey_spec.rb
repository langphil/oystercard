require 'journey'

describe Journey do
  subject(:new_journey) { described_class.new }
  subject(:journey) { described_class.new station_one, station_two}
  let(:station_one) { double(:station_one, :name => 'Victoria', :zone => 1) }
  let(:station_two) { double(:station_two, :name => 'Hammersmith', :zone => 1) }
  let(:station_three) { double(:station_two, :name => 'Bank', :zone => 2) }


  describe 'the creation of a new journey' do
    it 'a new journey to have an empty entry station' do
      expect(new_journey.entry_station).to eq nil
    end

    it 'a new journey to have an empty exit station' do
      expect(new_journey.exit_station).to eq nil
    end
  end

  describe 'set exit station' do
    it 'allows an exit station to be set' do
      expect { journey.set_exit_station(station_three) }.to change{ journey.exit_station }.to station_three
    end
  end

  describe 'check if a journey is complete' do
    it 'checks if the journey has been completed' do
      expect(journey.complete?).to eq true
    end
  end
end

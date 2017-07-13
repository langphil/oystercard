require 'journey'

describe Journey do
  subject(:new_journey) { described_class.new }
  subject(:journey) { described_class.new station_one, station_two}
  let(:station_one) { double(:station_one, :name => 'Victoria', :zone => 1) }
  let(:station_two) { double(:station_two, :name => 'Hammersmith', :zone => 1) }
  let(:station_three) { double(:station_two, :name => 'Bank', :zone => 2) }


  it 'ensures that a new journey to have an empty entry station' do
    expect(new_journey).to_not be_complete
  end

  it 'sets by default a fare' do
    expect(new_journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'checks if the journey has been completed' do
    expect(journey.complete?).to eq true
  end

  context 'when passed an entry station' do

    it 'has an entry station' do
      expect(journey.entry_station).to eq station_one
    end

    it 'returns a penalty when not exit station is given' do
      expect(new_journey.fare).to eq Journey::MINIMUM_FARE
    end

    context 'when passed an exit station' do
      it 'has an exit station' do
        expect(journey.exit_station).to eq station_two
      end

      it 'returns its own object when completing a journey' do
        expect(journey.set_exit_station(station_two)).to eq(station_two)
      end

      it 'ensures that an exit station has been set upon touching out' do
        expect { journey.set_exit_station(station_three) }.to change{ journey.exit_station }.to station_three
      end
    end
  end
end

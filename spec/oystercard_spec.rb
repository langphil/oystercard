require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  subject(:card_zero) { described_class.new(0) }
  let(:station) { double(:station) }
  let(:station_one) { double(:station_one) }
  let(:station_two) { double(:station_two) }

  describe 'New card creation' do
    it 'should have a default balance of cash' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'allows a user to set a new balance' do
      new_card = described_class.new 20
      expect(new_card.balance).to eq 20
    end

    it 'expects default card state to be not travelling' do
      expect(card).not_to be_in_journey
    end

    it 'should have an empty journeys array' do
      expect(card.journeys).to be_empty
    end
  end

  describe '.top_up' do
    it 'allows a user to top up the balance' do
      expect { card.top_up 1 }.to change { card.balance }.by 1
    end

    it 'raises an error if topped up above maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE - card.balance
      error = 'ERROR: card has reached the balance limit'
      card.top_up maximum_balance
      expect { card.top_up 1 }.to raise_error error
    end
  end

  describe '.touch_in' do
    it 'allows for a card to touch in' do
      expect(card.touch_in station).to eq station
    end

    it 'raises an error if the card has insufficient balance' do
      error = 'ERROR: The balance on your card is too low to touch in'
      expect { card_zero.touch_in station }.to raise_error error
    end

    it 'will remember the station the card touched in' do
      card.touch_in station
      expect(card.entry_station).to eq station
    end
  end

  describe '.touch_out' do
    it 'allows card to touch out' do
      card.touch_in station
      expect(card.touch_out station).to eq nil
    end

    it 'will save the exit station in the journey array' do
      card.touch_in station_one
      card.touch_out station_two
      expect(card.journeys[-1]).to eq [station_one, station_two]
    end

    it 'reduces the balance by the minimum fare' do
      card.touch_in station
      card.touch_out station
      expect(card.balance).to eq 10 - Oystercard::MINIMUM_FARE
    end
  end

  context '#in_journey?' do
    it 'checks if a card has been checked in' do
      expect { card.touch_in station }.to change { card.in_journey? }.to true
    end

    it 'checks if a card has been checked out' do
      card.touch_in station
      expect { card.touch_out station }.to change { card.in_journey? }.to false
    end
  end
end

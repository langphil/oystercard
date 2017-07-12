require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  subject(:card_zero) { described_class.new(0) }
  let(:station) { double(:station) }

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

    it 'should have an empty journeys hash' do
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

    it 'raises an error if a card is touched in twice' do
      error = 'ERROR: This card has already been touched in'
      card.touch_in station
      expect { card.touch_in station }.to raise_error error
    end

    it 'raises an error if the card has insufficient balance' do
      error = 'ERROR: The balance on your card is too low to touch in'
      expect { card_zero.touch_in station }.to raise_error error
    end

    it 'will remember the station the card touched in' do
      card.touch_in station
      expect(card.entry_station).to eq station
    end

    it 'will save the entry station in the journeys array' do
      card.touch_in station
      expect(card.journey).to have_key(:entry_station)
    end
  end

  describe '.touch_out' do
    it 'allows card to touch out' do
      card.touch_in station
      expect(card.touch_out station).to eq nil
    end

    it 'raises an error if a card is touched out twice' do
      error = 'ERROR: This card has already been touched out'
      expect { card.touch_out station }.to raise_error error
    end

    it 'will save the exit station in the journeys array' do
      card.touch_in station
      card.touch_out station
      expect(card.journey).to have_key(:exit_station)
    end
  end

  context '#in_journey?' do
    it 'allows a card to be in use or not' do
      expect(card.in_journey?).to be_truthy.or be(false)
    end
  end
end

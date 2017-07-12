require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station) { double(:station) }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  #it { is_expected.to respond_to(:deduct).with(1).argument }
  it { is_expected.to respond_to(:limit_line).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out) }
  it { is_expected.to respond_to(:in_journey?) }


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
  end

  describe '.top_up' do
    it 'allows a user to top up the balance' do
      expect { card.top_up 1 }.to change { card.balance }.by 1
    end

    it 'raises an error if topped up above maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      error = 'ERROR: card has reached the balance limit'
      card.top_up maximum_balance
      expect { card.top_up 1 }.to raise_error error
    end
  end

  describe '.touch_in' do
    it 'allows for a card to touch in' do
      card.top_up 10
      expect(card.touch_in station).to eq station
    end

    it 'raises an error if a card is touched in twice' do
      error = 'ERROR: This card has already been touched in'
      card.top_up 10
      card.touch_in station
      expect { card.touch_in station }.to raise_error error
    end

    it 'raises an error if the card has insufficient balance' do
      error = 'ERROR: The balance on your card is too low to touch in'
      expect { card.touch_in station }.to raise_error error
    end

    it 'will remember the station the card touched in' do
      card.top_up 10
      card.touch_in station
      expect(card.entry_station).to eq station
    end
  end

  describe '.touch_out' do
    it 'allows card to touch out' do
      card.top_up 10
      card.touch_in station
      expect(card.touch_out).to eq nil
    end

    it 'raises an error if a card is touched out twice' do
      error = 'ERROR: This card has already been touched out'
      expect { card.touch_out }.to raise_error error
    end
  end

  context '#in_journey?' do
    it 'allows a card to be in use or not' do
      expect(card.in_journey?).to be_truthy.or be(false)
    end
  end
end

require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:card_in_use) { double(:card, travelling: true) }

  it { is_expected.to respond_to(:top_up).with(1).argument }
  it { is_expected.to respond_to(:deduct).with(1).argument }

  describe 'New card creation' do
    it 'should have a default balance of cash' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'allows a user to set a new balance' do
      new_card = described_class.new 20
      expect(new_card.balance).to eq 20
    end
  end

  describe '#top_up' do
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

  describe '#deduct' do
    it 'allows for an amount to be deducted from the balance' do
      card.top_up 20
      expect { card.deduct 10 }.to change{ card.balance }.by (- 10)
    end
  end

  describe '#touch_in' do
    it 'allows for a card to be set as in use' do
      card.touch_in
      expect(card.in_journey?).to eq true
    end

    it 'raises an error if a card is touched in twice' do
      error = 'ERROR: This card has already been touched in'
      card.touch_in
      expect { card.touch_in }.to raise_error error
    end
  end

  describe '#touch_out' do
    it 'allows for a card to be set as not in use' do
      expect(card.in_journey?).to eq false
    end

    it 'raises an error if a card is touched in twice' do
      error = 'ERROR: This card has already been touched out'
      expect { card.touch_out }.to raise_error error
    end
  end

  describe '#in_journey?' do
    it 'allows a card to be in use or not' do
      expect(card.in_journey?).to be(true).or be(false)
    end
  end
end

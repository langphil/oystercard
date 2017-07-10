require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  describe 'New card creation' do

    it 'should have a default balance of cash' do
      expect(card.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'should allow a user to set a new balance' do
      new_card = described_class.new 20
      expect(new_card.balance).to eq 20
    end
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should allow a user to top up the balance' do
      expect { card.top_up 1 }.to change { card.balance }.by 1
    end
  end
end

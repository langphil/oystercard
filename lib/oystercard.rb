require_relative 'station'
require_relative 'journey'

# Oystercard object
class Oystercard
  attr_reader :balance, :entry_station, :journeys, :journey

  DEFAULT_BALANCE = 10
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = false
    @journeys = []
  end

  def top_up(amount)
    raise 'ERROR: card has reached the balance limit' if limit_line amount
    @balance += amount
  end

  def touch_in(station)
    raise 'ERROR: The balance on your card is too low to touch in' if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct MINIMUM_FARE
    @journeys << [entry_station, station]
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def limit_line(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

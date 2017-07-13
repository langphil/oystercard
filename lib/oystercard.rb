require_relative 'station'
require_relative 'journey'

# Oystercard object
class Oystercard
  attr_reader :balance, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = 10)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise 'ERROR: card has reached the balance limit' if limit_line amount
    @balance += amount
  end

  def touch_in(station)
    raise 'ERROR: The balance on your card is too low to touch in' if @balance < MINIMUM_FARE
    journey = Journey.new station
    @journeys << journey
    journeys.last.entry_station
  end

  def touch_out(station)
    deduct MINIMUM_FARE
    journeys.last.set_exit_station(station)
  end

  def in_journey?
    return false if journeys.empty?
    !journeys.last.complete?
  end

  private

  def limit_line(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end

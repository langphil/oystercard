# Oystercard object
class Oystercard
  attr_reader :balance, :entry_station, :journeys, :journey

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = false
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise 'ERROR: card has reached the balance limit' if limit_line amount
    @balance += amount
  end

  def touch_in(station)
    raise 'ERROR: This card has already been touched in' if @entry_station
    raise 'ERROR: The balance on your card is too low to touch in' if @balance < MINIMUM_FARE
    @journey.merge!(entry_station: station)
    @entry_station = station
  end

  def touch_out(station)
    raise 'ERROR: This card has already been touched out' unless @entry_station
    deduct MINIMUM_FARE
    @journey.merge!(exit_station: station)
    @journeys << @journey
    @entry_station = nil
  end

  def in_journey?
    @entry_station
  end

  def limit_line(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

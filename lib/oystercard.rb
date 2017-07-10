# Oystercard object
class Oystercard
  attr_reader :balance, :travelling

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @travelling = false
  end

  def top_up(amount)
    raise 'ERROR: card has reached the balance limit' if limit_line amount
    @balance += amount
  end

  def touch_in
    raise 'ERROR: This card has already been touched in' if @travelling
    raise 'ERROR: The balance on your card is too low to touch in' if @balance < MINIMUM_FARE
    @travelling = true
  end

  def touch_out
    raise 'ERROR: This card has already been touched out' unless @travelling
    deduct MINIMUM_FARE
    @travelling = false
  end

  def in_journey?
    @travelling
  end

  def limit_line(amount)
    (amount + @balance) > MAXIMUM_BALANCE
  end

  # Make this private
  def deduct(amount)
    @balance -= amount
  end
end

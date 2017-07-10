# Oystercard object
class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @travelling = false
  end

  def top_up(amount)
    fail 'ERROR: card has reached the balance limit' if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail 'ERROR: This card has already been touched in' if @travelling
    @travelling = true
  end

  def touch_out
    fail 'ERROR: This card has already been touched out' unless @travelling
    @travelling = false
  end

  def in_journey?
    @travelling
  end
end

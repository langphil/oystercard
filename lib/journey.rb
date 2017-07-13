# Journey Object
class Journey
  attr_reader :exit_station, :entry_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = fare
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def fare
    @fare = complete? ? PENALTY_FARE : MINIMUM_FARE
  end

  def complete?
    !!(exit_station && entry_station)
  end

end

# Journey Object
class Journey
  attr_reader :exit_station, :entry_station

  PENALTY_FARE = 6

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def fare
    return PENALTY_FARE if penalty?
  end

  def complete?
    !!(exit_station && entry_station)
  end

  private

  def penalty?
    (!entry_station || !exit_station)
  end
end

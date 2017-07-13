class Journey

  attr_reader :exit_station, :entry_station

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def complete?
    !!(exit_station && entry_station)
  end
end

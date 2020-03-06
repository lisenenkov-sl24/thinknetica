class Route
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def to_s
    "#{stations[0]} - #{stations[-1]}"
  end

  def print_stations
    @stations.each { |s| puts s }
  end

  def add(station)
    @stations.insert(-2, station)
    self
  end

  def remove
    @stations.delete_at(-2) if @stations.size > 2
  end
end

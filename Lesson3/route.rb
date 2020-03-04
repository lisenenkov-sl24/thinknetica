class Route
  attr_reader :stations
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add(station)
    @stations.insert(-1, station)
  end

  def remove
    @stations.delete_at(-2) if @stations.size > 2
  end
end

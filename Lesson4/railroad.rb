class Railroad
  attr_accessor stations, routes, trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def self.demo
    railroad = Railroad.new
    #stations
    railroad.stations.push(Station.new('Москва'))
    railroad.stations.push(Station.new('СПБ'))
    railroad.stations.push(Station.new('Воронеж'))
    railroad.stations.push(Station.new('НН'))
    railroad.stations.push(Station.new('Самара'))
    railroad.stations.push(Station.new('Ухань'))
    #routes

    railroad

    railroad
  end

  protected

  attr_writer stations, routes, trains
end

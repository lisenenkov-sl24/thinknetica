class Railroad
  attr_accessor stations, routes, trains

  def initialize
    @stations = {}
    @routes = []
    @trains = []
  end

  def self.demo
    railroad = Railroad.new
    #stations
    ['Москва', 'СПБ', 'Воронеж', 'НН', 'Самара', 'Ухань'].each do |station_name|
      @stations[station_name] = Station.new(station_name)
    end
    #routes
    route1 = Route.new(stations['Москва'], stations['Воронеж'])
    route1.add(stations['Самара'])
    railroad.routes.push(route1)

    railroad
  end

  protected

  attr_writer stations, routes, trains
end

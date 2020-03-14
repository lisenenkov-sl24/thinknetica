require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'

class Railroad
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = {}
    @routes = []
    @trains = {}
  end

  def self.demo
    railroad = Railroad.new
    # stations
    %w[Москва СПБ Воронеж НН Самара Ухань].each do |station_name|
      railroad.stations[station_name] = Station.new(station_name)
    end
    railroad.stations['СПБ'].name = 'Петроград'
    railroad.stations['СПБ'].name = 'Ленинград'
    railroad.stations['СПБ'].name = 'СПБ'
    
    #puts railroad.stations['СПБ'].name_history.to_s
    #Station.new(1)

    # routes
    route1 = Route.new(railroad.stations['Москва'],
                       railroad.stations['Воронеж'])
    route1.add(railroad.stations['Самара'])
    railroad.routes.push(route1)

    route2 = Route.new(railroad.stations['СПБ'], railroad.stations['Ухань'])
    route2.add(railroad.stations['НН'])
    route2.add(railroad.stations['Воронеж'])
    railroad.routes.push(route2)

    # trains
    train1 = PassengerTrain.new('МОВ-01')
    car = PassengerCar.new(100)
    51.times { car.occupy_place }
    train1.hook_railcar(car)
    car = PassengerCar.new(90)
    34.times { car.occupy_place }
    train1.hook_railcar(car)
    car = PassengerCar.new(100)
    4.times { car.occupy_place }
    train1.hook_railcar(car)
    train1.route = route1
    railroad.trains[train1.number] = train1

    train2 = CargoTrain.new('СПУ01')
    car = CargoCar.new(50)
    car.occupy_volume(20.5)
    train2.hook_railcar(car)
    car = CargoCar.new(45)
    car.occupy_volume(23.5)
    train2.hook_railcar(car)
    train2.route = route2
    railroad.trains[train2.number] = train2

    railroad
  end
end

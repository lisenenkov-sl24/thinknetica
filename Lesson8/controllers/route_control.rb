require_relative 'train_control'
require_relative 'station_control'

module RouteControl
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
  def self.manage_route(railroad)
    begin
      ask_route(railroad)
    rescue RuntimeError => e
      puts e.message
      return
    end

    loop do
      puts 'Выберите вариант:'
      puts ' 1 список станций'
      puts ' 2 добавить станцию'
      puts ' 3 удалить станцию'
      puts ' 4 назначить маршрут поезду'
      puts ' 0 стоп'

      option = gets.chomp.to_i
      case option
      when 0
        break
      when 1
        route.print_stations
      when 2
        station = StationControl.ask_station(railroad)
        route.add(station) unless station.nil?
      when 3
        route.remove
      when 4
        train = TrainControl.ask_train(railroad)
        next if train.nil?

        train.route = route
      else
        puts 'Неверный выбор!!!'
      end
    end
  end

  def self.ask_route(railroad)
    puts 'Выберите вариант:'
    puts ' 0 создать маршрут'
    railroad.routes.each_with_index { |route, i| puts " #{i + 1} #{route}" }
    option = gets.chomp.to_i
    case option
    when 0
      create_route
    when 1..railroad.routes.count
      railroad.routes[option - 1]
    else
      raise 'Неверный выбор!!!'
    end
  end
  # rubocop:enable all

  def self.create_route(railroad)
    station1 = StationControl.ask_station(railroad, 'Начальная станция')
    return if station1.nil?

    station2 = StationControl.ask_station(railroad, 'Конечная станция')
    return if station2.nil?

    route = Route.new(station1, station2)
    railroad.routes.push(route)
    route
  end
end

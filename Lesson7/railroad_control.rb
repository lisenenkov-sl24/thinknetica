require_relative 'railroad'

class RailroadControl
  def initialize(railroad)
    @railroad = railroad
  end

  def main_menu
    loop do
      puts 'Выберите вариант:'
      puts ' 1 создать станцию'
      puts ' 2 создать поезд'
      puts ' 3 управление маршрутами'
      puts ' 4 управление поездом'
      puts ' 5 список поездов на станции'
      puts ' 6 список поездов на всех станциях'
      puts ' 0 стоп'

      option = gets.chomp.to_i
      case option
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        manage_route
      when 4
        manage_train
      when 5
        station_trains
      when 6
        all_station_trains
      else
        puts 'неизвестная команда'
      end
    end
  end

  private

  def create_station
    puts 'Название:'
    try_num = 1
    begin
      name = gets.chomp.encode('utf-8')
      raise 'Станция уже существует!!!' if @railroad.stations[name]

      @railroad.stations[name] = Station.new(name)
    rescue RuntimeError => e
      puts e.message
      try_num += 1
      retry if try_num <= 5
    end
  end

  def ask_station(question = 'Станция')
    puts "#{question} (? вывести список)"
    loop do
      name = gets.chomp.encode('utf-8')
      return nil if name.empty?

      if name == '?'
        @railroad.stations.each_key { |key| puts key }
        next
      end
      return @railroad.stations[name] if @railroad.stations.key?(name)

      puts 'Станция не существует!!!'
    end
  end

  def ask_train(question = 'Поезд')
    puts "#{question} (? вывести список)"
    loop do
      name = gets.chomp.encode('utf-8')
      return nil if name.empty?

      if name == '?'
        @railroad.trains.each_key { |key| puts key }
        next
      end
      return @railroad.trains[name] if @railroad.trains.key?(name)

      puts 'Поезд не существует!!!'
    end
  end

  def create_train
    try_num = 1
    begin
      puts 'Номер:'
      number = gets.chomp.encode('utf-8')
      raise 'Поезд уже существует!!!' if @railroad.trains[number]

      puts 'Тип (п-пассажирский, г-грузовой):'
      type_string = gets.chomp.encode('utf-8')
      case type_string
      when 'п'
        type = PassengerTrain
      when 'г'
        type = CargoTrain
      else
        raise 'Неизвестный тип!!!'
      end

      @railroad.trains[number] = type.new(number)

      puts "Создан #{@railroad.trains[number]}"

      @railroad.trains[number]
    rescue RuntimeError => e
      puts e.message
      try_num += 1
      retry if try_num <= 5
    end
  end

  def create_railcar
    try_num = 1
    begin
      puts 'Тип (п-пассажирский, г-грузовой):'
      type_string = gets.chomp.encode('utf-8')
      case type_string
      when 'п'
        puts 'Число мест:'
        places = gets.chomp.to_i
        PassengerCar.new(places)
      when 'г'
        puts 'Объем:'
        volume = gets.chomp.to_f
        CargoCar.new(volume)
      else
        raise 'Неизвестный тип!!!'
      end
    rescue RuntimeError => e
      puts e.message
      try_num += 1
      retry if try_num <= 5
    end
  end

  def manage_route
    puts 'Выберите вариант:'
    puts ' 0 создать маршрут'
    @railroad.routes.each_index { |i| puts " #{i + 1} #{@railroad.routes[i]}" }
    option = gets.chomp.to_i
    case option
    when 0
      station1 = ask_station('Начальная станция')
      return if station1.nil?

      station2 = ask_station('Конечная станция')
      return if station2.nil?

      route = Route.new(station1, station2)
      @railroad.routes.push(route)
    when 1..@railroad.routes.count
      route = @railroad.routes[option - 1]
    else
      puts 'Неверный выбор!!!'
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
        station = ask_station
        route.add(station) unless station.nil?
      when 3
        route.remove
      when 4
        train = ask_train
        next if train.nil?

        train.route = route
      else
        puts 'Неверный выбор!!!'
      end
    end
  end

  def manage_train
    train = ask_train
    return if train.nil?

    loop do
      puts train
      puts ' 1 Добавить вагон к поезду'
      puts ' 2 Отцепить вагон от поезда'
      puts ' 3 Переместить поезд по маршруту вперед'
      puts ' 4 Переместить поезд по маршруту назад'
      puts ' 5 Список вагонов'
      puts " 6 Занять #{train.type == :cargo ? 'объем' : 'место'}"
      puts ' 0 стоп'

      option = gets.chomp.to_i
      case option
      when 0
        break
      when 1
        railcar = create_railcar
        train.hook_railcar(railcar)
      when 2
        train.unhook_railcar
      when 3
        train.move_forward
      when 4
        train.move_backward
      when 5
        print_train_railcars(train)
      when 6
        puts "Номер вагона (1-#{train.railcars.count}):"
        railcar_index = gets.chomp.to_i - 1
        railcar = train.railcars[railcar_index]
        if train.type == :cargo
          puts 'Объем:'
          volume = gets.chomp.to_f
          railcar.occupy_volume(volume)
        else
          railcar.occupy_place
        end
      else
        puts 'Неверный выбор!!!'
      end
    end
  end

  def station_trains
    station = ask_station
    return if station.nil?

    print_station_trains(station)
  end

  def all_station_trains
    @railroad.stations.each_value do |station|
      puts "Поезда на станции #{station.name}"
      print_station_trains(station, '  ')
    end
  end

  def print_station_trains(station, prefix = '')
    station.each_train do |train|
      puts "#{prefix}#{train}"
      print_train_railcars(train, "#{prefix}  ")
    end
  end

  def print_train_railcars(train, prefix = '')
    train.each_railcar do |railcar, index|
      puts "#{prefix}#{index + 1}: #{railcar}"
    end
  end
end

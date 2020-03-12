require_relative 'railcar_control'
require_relative 'common_control'

module TrainControl
  def self.ask_train(railroad, question = 'Поезд')
    puts "#{question} (? вывести список)"
    loop do
      name = gets.chomp.encode('utf-8')
      return nil if name.empty?

      if name == '?'
        railroad.trains.each_key { |key| puts key }
        next
      end
      return railroad.trains[name] if railroad.trains.key?(name)

      puts 'Поезд не существует!!!'
    end
  end

  def self.create_train(railroad)
    CommonControl.try_n_times(5) do
      puts 'Номер:'
      number = gets.chomp.encode('utf-8')
      raise 'Поезд уже существует!!!' if railroad.trains[number]

      train_type = {
        passenger: PassengerTrain,
        cargo: CargoTrain
      }[CommonControl.ask_train_type]
      railroad.trains[number] = train_type.new

      puts "Создан #{railroad.trains[number]}"

      railroad.trains[number]
    end
  end

  def self.ask_railcar(train)
    puts "Номер вагона (1-#{train.railcars.count}):"
    railcar_index = gets.chomp.to_i - 1
    train.railcars[railcar_index]
  end

  def self.manage_train(railroad)
    train = ask_train(railroad)
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
        railcar = RailcarControl.create_railcar
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
        railcar = ask_railcar
        RailcarControl.occupy(railcar)
      else
        puts 'Неверный выбор!!!'
      end
    end
  end

  def self.print_train_railcars(train, prefix = '')
    train.each_railcar do |railcar, index|
      puts "#{prefix}#{index + 1}: #{railcar}"
    end
  end
end

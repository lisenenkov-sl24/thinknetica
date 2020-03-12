require_relative 'common_control'

module RailcarControl
  def self.create_railcar
    CommonControl.try_n_times(5) do
      train_type = CommonControl.ask_train_type
      case train_type
      when :passenger
        create_passenger_car
      when :cargo
        create_cargo_car
      end
    end
  end

  def self.occupy(railcar)
    if railcar.type == :cargo
      puts 'Объем:'
      volume = gets.chomp.to_f
      railcar.occupy_volume(volume)
    else
      railcar.occupy_place
    end
  end

  private_class_method def self.create_cargo_car
    puts 'Объем:'
    volume = gets.chomp.to_f
    CargoCar.new(volume)
  end

  private_class_method def self.create_passenger_car
    puts 'Число мест:'
    places = gets.chomp.to_i
    PassengerCar.new(places)
  end
end

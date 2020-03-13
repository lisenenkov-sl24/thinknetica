require_relative 'train_control'
require_relative 'common_control'

module StationControl
  def self.create_station(railroad)
    puts 'Название:'
    CommonControl.try_n_times(5) do
      name = gets.chomp.encode('utf-8')
      raise 'Станция уже существует!!!' if railroad.stations[name]

      railroad.stations[name] = Station.new(name)
    end
  end

  # rubocop:disable Metrics/MethodLength
  def self.ask_station(railroad, question = 'Станция')
    puts "#{question} (? вывести список)"
    loop do
      name = gets.chomp.encode('utf-8')
      return nil if name.empty?

      if name == '?'
        railroad.stations.each_key { |key| puts key }
        next
      end
      return railroad.stations[name] if railroad.stations.key?(name)

      puts 'Станция не существует!!!'
    end
  end
  # rubocop:enable all

  def self.station_trains(railroad)
    station = ask_station(railroad)
    return if station.nil?

    print_station_trains(station)
  end

  def self.print_station_trains(station, prefix = '')
    station.each_train do |train|
      puts "#{prefix}#{train}"
      TrainControl.print_train_railcars(train, "#{prefix}  ")
    end
  end
end

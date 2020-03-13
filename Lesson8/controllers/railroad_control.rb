require_relative '..\railroad'
require_relative 'station_control'
require_relative 'route_control'
require_relative 'train_control'

class RailroadControl
  def initialize(railroad)
    @railroad = railroad
  end

  # rubocop:disable Metrics/MethodLength, Metrics/BlockLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
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
        StationControl.create_station(@railroad)
      when 2
        TrainControl.create_train(@railroad)
      when 3
        RouteControl.manage_route(@railroad)
      when 4
        TrainControl.manage_train(@railroad)
      when 5
        StationControl.station_trains(@railroad)
      when 6
        print_all_station_trains
      else
        puts 'неизвестная команда'
      end
    end
  end
  # rubocop:enable all

  private

  def print_all_station_trains
    @railroad.stations.each_value do |station|
      puts "Поезда на станции #{station.name}"
      StationControl.print_station_trains(station, '  ')
    end
  end
end

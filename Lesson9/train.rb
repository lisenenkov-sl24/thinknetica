require_relative 'manufacturer'
require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Train
  include Manufacturer
  include InstanceCounter
  extend Validation

  attr_reader :number, :railcars, :route, :type
  validate :number, :format, /^[[:word:]\d]{3}-?[[:word:]\d]{2}$/
  validate :number, :type, String

  def initialize(number)
    @number = number
    @route = nil
    @railcars = []

    validate!

    register_instance
  end

  def to_s
    t_type = case @type
             when :cargo
               'Грузовой поезд'
             when :passenger
               'Пасажирский поезд'
             else
               'Поезд'
             end
    "#{t_type} №#{number} и #{railcars.count} вагонов. \
    По маршруту #{route} на станции #{current_station}"
  end

  def hook_railcar(railcar)
    railcars.push(railcar) if railcar.type == @type
  end

  def unhook_railcar
    railcars.pop
  end

  def each_railcar
    railcars.each_with_index { |railcar, index| yield(railcar, index) }
  end

  def route=(route)
    current_station&.send(self)
    @route = route
    move(route.stations.first)
  end

  def current_station
    return nil if @route.nil?

    index = current_station_index
    return nil if index.nil?

    route.stations[index]
  end

  def prev_station
    index = current_station_index
    index.positive? ? @route.stations[index - 1] : nil
  end

  def next_station
    index = current_station_index
    index + 1 < @route.stations.size ? @route.stations[index + 1] : nil
  end

  def move_forward
    move(next_station)
  end

  def move_backward
    move(prev_station)
  end

  private

  def current_station_index
    return nil if @route.nil?

    @route.stations.index { |station| station.trains.include?(self) }
  end

  def move(to)
    current_station&.send(self)
    to&.accept(self)
  end
end

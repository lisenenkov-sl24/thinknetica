class Train
  attr_reader :number, :railcars, :route

  def initialize(number)
    @number = number
    @route = nil
    @railcars = []
  end

  def to_s
    "#{train_type} №#{number} и #{railcars.count} вагонов. По маршруту #{route} на станции #{current_station}"
  end

  def train_type
    'Поезд'
  end

  def hook_railcar(railcar)
    railcars.push(railcar)
  end

  def unhook_railcar
    railcars.pop
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
    index > 0 ? @route.stations[index - 1] : nil
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

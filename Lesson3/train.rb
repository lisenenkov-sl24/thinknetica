class Train
  attr_reader :number, :type, :railcar_count, :speed

  def initialize(number, type, railcar_count)
    @number = number
    @type = type
    @railcar_count = railcar_count
  end

  def accelerate(value = 1)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def hook_railcar
    @railcar_count += 1 if @speed == 0
  end

  def unhook_railcar
    @railcar_count -= 1 if @railcar_count > 0 && @speed == 0
  end

  def route=(route)
    current_station&.send(self)
    @route = route
    move(route[0])
  end

  def current_station
    return nil if @route.nil?

    index = current_station_index
    return nil if index.nil?

    stations[index]
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
    unless to.nil?
      @current_station.send(self)
      @current_station = to
      @current_station.accept(self)
    end
    @current_station
  end
end

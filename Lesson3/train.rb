class Train
  attr_reader :number, :type, :railcar_count, :speed, :current_station

  def initialize(number, type, railcar_count)
    @number = number
    @type = type
    @railcar_count = railcar_count
    @current_station = nil
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
    @current_station.send(self) unless @station.nil?
    @route = route
    @current_station = route[0]
    @current_station.accept(self)
  end

  def prev_station
    index = @route.stations.index(@station)
    index > 0 ? @route.stations[index - 1] : nil
  end

  def next_station
    index = @route.stations.index(@station)
    index + 1 < @route.stations.size ? @route.stations[index + 1] : nil
  end

  def move_forward
    move(next_station)
  end

  def move_backward
    move(prev_station)
  end

  private

  def move(to)
    unless to.nil?
      @current_station.send(self)
      @current_station = to
      @current_station.accept(self)
    end
    @current_station
  end
end

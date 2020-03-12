require_relative 'railcar'

class PassengerCar < Railcar
  attr_accessor :places
  attr_reader :occupied_places

  def initialize(places)
    @type = :passenger
    @places = places
    @occupied_places = 0
  end

  def occupy_place
    @occupied_places += 1 if @occupied_places < @places
  end

  def free_place
    @occupied_places -= 1 if @occupied_places.positive?
  end

  def remaining_places
    @places - @occupied_places
  end

  def to_s
    "Пассажирский вагон свободно #{remaining_places}, занято #{occupied_places}"
  end
end

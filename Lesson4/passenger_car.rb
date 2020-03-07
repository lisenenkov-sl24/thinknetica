require_relative 'railcar'

class PassengerCar < Railcar
  def initialize
    @type = :passenger
  end
end

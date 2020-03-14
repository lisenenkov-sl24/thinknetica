require_relative 'train'
require_relative 'passenger_car'

class PassengerTrain < Train
  def initialize(number)
    super(number)
    @type = :passenger
  end
end

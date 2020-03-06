require_relative 'train'
require_relative 'passenger_car'

class PassengerTrain < Train
  def initialize(number)
    super(number)
  end

  def hook_railcar(railcar)
    super(railcar) if railcar.is_a?(PassengerCar)
  end

  def train_type
    'Пасажирский поезд'
  end
end

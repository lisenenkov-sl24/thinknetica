require_relative 'train'
require_relative 'cargo_car'

class CargoTrain < Train
  def initialize(number)
    super(number)
  end

  def hook_railcar(railcar)
    super(railcar) if railcar.is_a?(CargoCar)
  end

  def train_type
    'Грузовой поезд'
  end
end

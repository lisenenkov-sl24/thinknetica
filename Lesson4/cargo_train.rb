require_relative 'train'
require_relative 'cargo_car'

class CargoTrain < Train
  def initialize(number)
    super(number)
    @type = :cargo
  end
end

class CargoTrain < Train
  def initialize(number)
    super(number)
  end

  def hook_railcar(railcar)
    super(railcar) if railcar.is_a?(CargoCar)
  end
end

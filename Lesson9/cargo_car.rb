require_relative 'railcar'

class CargoCar < Railcar
  attr_accessor :volume
  attr_reader :occupied_volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def occupy_volume(vol)
    @occupied_volume = [@occupied_volume + vol, @volume].min
  end

  def free_volume(vol)
    @occupied_volume = [@occupied_volume - vol, 0].max
  end

  def remaining_volume
    @volume - @occupied_volume
  end

  def to_s
    "Грузовой вагон свободно #{remaining_volume}, занято #{occupied_volume}"
  end
end

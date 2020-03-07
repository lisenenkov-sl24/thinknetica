require_relative 'railcar'

class CargoCar < Railcar
  def initialize
    @type = :cargo
  end
end

require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []

    check_validity

    register_instance(self)
  end

  def valid?
    check_validity
    true
  rescue RuntimeError
    false
  end

  def accept(train)
    @trains.push(train)
  end

  def send(train)
    @trains.delete(train)
  end

  def trains_by_type(train_type)
    @trains.select { |train| train.is_a?(train_type) }
  end

  def to_s
    @name
  end

  private

  def check_validity
    raise 'Название не заполнено' if !@name || @name.empty?
  end
end

require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []

    validite!

    register_instance(self)
  end

  def valid?
    validite!
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

  def each_train
    trains.each { |train| yield(train) }
  end

  def to_s
    @name
  end

  private

  def validite!
    raise 'Название не заполнено' if !@name || @name.empty?
  end
end

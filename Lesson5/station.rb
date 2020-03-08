require_relative 'instance_counter'
class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    @@all.push(self)
    register_instance(self)
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

  def self.all
    @@all
  end
end

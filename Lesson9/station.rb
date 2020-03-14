require_relative 'modules/instance_counter'
require_relative 'modules/accessors'
require_relative 'modules/validation'

class Station
  extend Accessors
  extend Validation
  include InstanceCounter

  attr_accessor_with_history :name
  validate :name, :presence
  validate :name, :type, String
  attr_reader :trains

  def initialize(name)
    self.name = name
    @trains = []

    validate!

    register_instance
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
end

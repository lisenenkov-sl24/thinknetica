module InstanceCounter
  module ClassMethods
    attr_accessor :instances
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  protected

  def register_instance(instance)
    self.class.instances = [] if self.class.instances.nil?
    self.class.instances.push(instance)
  end
end

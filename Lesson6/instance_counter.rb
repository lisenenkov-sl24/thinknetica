module InstanceCounter
  module ClassMethods
    attr_writer :instances
    def instances
      @instances || 0
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  protected

  def register_instance(instance)
    self.class.instances += 1
  end
end

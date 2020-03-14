module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_name = "@#{name}".to_sym
      attr_name_history = "@#{name}_history".to_sym
      getter_name_history = "#{name}_history".to_sym
      define_method(name.to_sym) { instance_variable_get(attr_name) }
      define_method(getter_name_history) do
        result = instance_variable_get(attr_name_history)
        unless result
          result = []
          instance_variable_set(attr_name_history, result)
        end
        result
      end
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(attr_name, value)
        method(getter_name_history).call.push(value)
      end
    end
  end
end

module Validation
  def validate(name, validation_type, param = nil)
    attr_name = "@#{name}".to_sym
    @validations ||= Hash.new { |hash, key| hash[key] = [] }
    @validations[attr_name].push(
      lambda do |attr_value|
        validation_method = method("validate_#{validation_type}".to_sym)
        validation_method.call(attr_value, name, param)
      end
    )
    define_validate_methods(@validations) unless method_defined?(:validate!)
  end

  private

  def validate_presence(attr_value, name, param)
    raise "Значение #{name} не заполнено" if !attr_value || attr_value == ''
  end

  def validate_format(attr_value, name, format)
    raise "Значение #{name} не соответствует формату #{format}" if attr_value !~ format
  end

  def validate_type(attr_value, name, type)
    raise "Значение #{name} должно быть типа #{type}" unless attr_value.is_a? type
  end

  def define_validate_methods(validations)
    define_method(:validate!) do
      validations.each do |a_name, check_methods|
        attr = instance_variable_get(a_name)
        check_methods.each { |check_method| check_method.call(attr) }
      end
    end
    define_method(:valid?) do
      begin
        validate!
        true
      rescue RuntimeError
        false
      end
    end
  end
end

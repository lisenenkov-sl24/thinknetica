module Validation
  def validate(name, validation_type, param = nil)
    attr_name = "@#{name}".to_sym
    @validations ||= Hash.new { |hash, key| hash[key] = [] }
    @validations[attr_name].push(
      case validation_type
      when :presence
        validate_presence(name)
      when :format
        validate_format(name, param)
      when :type
        validate_type(name, param)
      else
        raise 'Неизвестный тип валидации'
      end
    )
    define_validate_methods(@validations) unless method_defined?(:validate!)
  end

  private

  def validate_presence(name)
    lambda do |attr_value|
      raise "Значение #{name} не заполнено" if !attr_value || attr_value == ''
    end
  end

  def validate_format(name, format)
    lambda do |attr_value|
      if attr_value !~ format
        raise "Значение #{name} не соответствует формату #{format}"
      end
    end
  end

  def validate_type(name, type)
    lambda do |attr_value|
      unless attr_value.is_a? type
        raise "Значение #{name} должно быть типа #{type}"
      end
    end
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

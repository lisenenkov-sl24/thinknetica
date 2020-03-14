module Validation
  def validate(name, validation_type, param = nil)
    attr_name = "@#{name}".to_sym
    @validations ||= Hash.new { |hash, key| hash[key] = [] }
    validations = @validations
    validations[attr_name].push(
      case validation_type
      when :presence
        ->(attr_value) { raise "Значение #{name} не заполнено" if !attr_value || attr_value == '' }
      when :format
        ->(attr_value) { raise "Значение #{name} не соответствует формату #{param}" if attr_value !~ param }
      when :type
        ->(attr_value) { raise "Значение #{name} должно быть типа #{param}" unless attr_value.is_a? param }
      else
        raise 'Неизвестный тип валидации'
      end
    )
    return if method_defined?(:validate!)

    define_method(:validate!) do
      validations.each do |attr_name, check_methods|
        attr = instance_variable_get(attr_name)
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
  class << self
  end
end

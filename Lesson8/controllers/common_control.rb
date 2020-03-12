module CommonControl
  def self.try_n_times(count)
    try_num = 1
    begin
      yield
    rescue RuntimeError => e
      puts e.message
      try_num += 1
      retry if try_num <= count
      nil
    end
  end

  def self.ask_train_type
    puts 'Тип (п-пассажирский, г-грузовой):'
    type_string = gets.chomp.encode('utf-8')
    case type_string
    when 'п'
      :passenger
    when 'г'
      :cargo
    else
      raise 'Неизвестный тип!!!'
    end
  end
end

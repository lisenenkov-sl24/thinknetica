require 'date'

months_length = {}
12.times { |m|  months_length[m + 1] = Date.new(2020, m + 1, -1).mday }
months_length.each do |month, days|
  puts Date::MONTHNAMES[month] if days == 30
end

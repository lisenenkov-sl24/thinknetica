def dayofyear(day, month, year)
  months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  dayofyear = day
  (1..(month - 1)).each { |m| dayofyear += months[m - 1] }
  dayofyear += 1 if month > 2 && year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)
  dayofyear
end

puts 'День, месяц, год через запятую'
(day, month, year) = gets.chomp.split(',').map(&:to_i)
yday = dayofyear(day, month, year)

puts yday

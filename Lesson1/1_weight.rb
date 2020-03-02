puts 'Ваше имя:'
name = gets.chomp
puts 'Ваш рост:'
height = gets.chomp
best_weight = ((height.to_i - 110) * 1.15).round(2)
if best_weight >= 0
  puts "#{name}, Ваш идеальный вес #{best_weight}"
else
  puts "Ваш вес уже оптимальный"
end
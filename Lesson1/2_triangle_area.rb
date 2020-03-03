puts 'Основание треугольника'
base = gets.chomp.to_f
puts 'Высота треугольника'
height = gets.chomp.to_f
area = (base * height / 2).round(5)
puts "Площадь #{area}"

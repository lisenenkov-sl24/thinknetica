puts "Основание треугольника"
base = gets.chomp
puts "Высота треугольника"
height = gets.chomp
area = (base.to_f * height.to_f / 2).round(5)
puts "Площадь #{area}"
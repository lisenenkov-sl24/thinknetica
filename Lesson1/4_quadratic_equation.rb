puts '"Коэффициенты уравнения a*x^2 + b*x + c = 0, через запятую'
(a, b, c) = gets.chomp.split(',').map(&:to_f)
d = b**2 - 4 * a * c
if d < 0
  puts "Дискриминант #{d}. Корней нет"
elsif d == 0
  puts "Дискриминант #{d}. Корень #{-b / 2 / a}"
else
  sqrtd = Math.sqrt(d)
  puts "Дискриминант #{d}. Корни #{(b + sqrtd) / -2 / a} и #{(b - sqrtd) / -2 / a}"
end

shopping_cart = Hash.new { |hash, key| hash[key] = Hash.new(0) }

loop do
  puts 'Название товара'
  goods_name = gets.chomp.encode('utf-8')
  break if goods_name == 'стоп'

  puts 'Цена за единицу'
  price = gets.chomp.to_f
  puts 'Количество'
  count = gets.chomp.to_f

  shopping_cart[goods_name][price] += count
end

puts shopping_cart

total_sum = shopping_cart.sum do |goods_name, counts|
  sum = counts.sum { |price, count| price * count }
  puts "Сумма за #{goods_name} равна #{sum}"
  sum
end

puts "Сумма за все равна #{total_sum}"

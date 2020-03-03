array_of_divisible_by_five = (1..100).to_a.select { |v| v % 5 == 0 }
puts array_of_divisible_by_five
array_of_divisible_by_five = (1..20).to_a.map { |v| v * 5 }
puts array_of_divisible_by_five

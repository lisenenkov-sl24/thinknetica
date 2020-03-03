fibonacci = [1, 1]
loop do
  next_value = fibonacci[-1] + fibonacci[-2]
  break if next_value > 100

  fibonacci.push(next_value)
end
puts fibonacci

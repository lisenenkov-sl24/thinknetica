puts "Стороны треугольника, через запятую"
edges = gets.chomp.split(",").map {|x| x.to_f}.sort
puts "Треугольник #{(edges[0]**2 + edges[1]**2 == edges[2]**2)? "" : "не "}прямоугольный"
puts "Треугольник #{(edges[0] == edges[1] && edges[1]== edges[2])? "" : "не "}равносторонний" 
puts "Треугольник #{(edges[0] == edges[1] || edges[1]== edges[2])? "" : "не "}равнобедренный" 

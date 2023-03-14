puts 'A?'
a = gets.chomp.to_i
puts 'B?'
b = gets.chomp.to_i
puts 'C?'
c = gets.chomp.to_i

puts 'Это Прямоугольный треугольник' if a**2 == b**2 + c**2
puts 'Это Прямоугольный треугольник' if b**2 == a**2 + c**2
puts 'Это Прямоугольный треугольник' if c**2 == b**2 + a**2
puts 'Этот треугольник равносторонний' if a == b && b == c
puts 'Этот треугольник равнобедренный' if a == b || a == c || b == c

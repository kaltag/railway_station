puts 'A?'
a = gets.chomp.to_i
puts 'B?'
b = gets.chomp.to_i
puts 'C?'
c = gets.chomp.to_i

puts "Дискриминант = #{d = b * b - (4 * a * c)}"

if d.positive?
  puts "x1 = #{(-b + Math.sqrt(d)) / (2 * a)}"
  puts "x2 = #{(-b - Math.sqrt(d)) / (2 * a)}"
elsif (d = 0)
  puts "x1 = #{(-b + Math.sqrt(d)) / (2 * a)}"
else
  puts 'Нет корней'
end

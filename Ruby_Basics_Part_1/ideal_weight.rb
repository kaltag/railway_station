puts "What's your name?"
name = gets.chomp
puts "What's your height?"
height = gets.chomp
ideal_weight = (height.to_i - 110) * 1.15
if ideal_weight.positive?
  puts "Hi #{name}! Your ideal weight = #{ideal_weight}"
else
  puts "Hi #{name}! Your weight is perfect"
end

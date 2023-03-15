purchases = {}
loop do
  puts 'название товара'
  name = gets.chomp
  puts 'ценa за единицу '
  price = gets.chomp.to_f
  puts 'кол-во?'
  quantity = gets.chomp.to_i

  purchases[name] = { price: price, quantity: quantity }

  puts 'введите stop, чтобы закончить'
  puts 'Или любой символ чтобы добавить еще один товар'
  input = gets.chomp
  break if input == 'stop'
end

itog = 0

puts purchases
purchases.each do |key, value|
  puts "#{key} = #{value[:price] * value[:quantity]}"
  itog += value[:price] * value[:quantity]
end
puts "Общая сумма равна #{itog}"

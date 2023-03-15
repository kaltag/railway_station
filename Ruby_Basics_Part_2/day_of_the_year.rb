puts 'day'
day = gets.chomp.to_i
puts 'month?'
month = gets.chomp.to_i
puts 'year?'
year = gets.chomp.to_i

all_days = 0
arr_Month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

(1..month - 1).each do |i|
  all_days += arr_Month[i]
end

all_days += day

all_days += 1 if month > 2 && year % 4 == 0 && !(year % 100 == 0 && year % 400 != 0)

puts "it's #{all_days} days"

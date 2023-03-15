array = []
first = 0
second = 1

array << first
array << second
10.times do
  array << first + second
  first = second
  second = array.last
end
puts array

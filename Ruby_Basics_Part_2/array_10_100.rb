array = []
i = 10
while i <= 100
  array << i
  i += 5
end
puts array

# 2 вариант(короткий)
puts (10..100).step(5).to_a

vowel = {}
('a'..'z').each_with_index do |letter, index|
  vowel[letter] = index + 1 if %w[a e i o y u].any? { |s| letter.include? s }
end
puts vowel

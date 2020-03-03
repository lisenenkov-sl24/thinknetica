vowels = {}
26.times do |char_index|
  char = (char_index + 'a'.ord).chr
  vowels[char] = char_index + 1 if char =~ /[aeiou]/
end
puts vowels

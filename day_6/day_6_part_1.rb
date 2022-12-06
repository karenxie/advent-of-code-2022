input_file = ARGV[0]
input = File.read(input_file)
length = 4
index = input.chars.each_cons(length).find_index { |arr| arr.uniq.length == length} + length
puts index
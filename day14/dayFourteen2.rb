input = IO.readlines("dayFourteenInput.txt").map{|line| line.chomp}

template = input[0]
rules = input[2..-1].map{|c| c.split(" -> ")}.to_h

list = [nil]
ptr = list

template.chars.each { |n|
   ptr[0] = n
   ptr[1] = [nil]
   ptr = ptr[1]
}

puts template
puts list.flatten.join

10.times { |i|
   ptr = list
   while(ptr[1][0]!=nil) do
      swap = ptr[1]
      ptr[1] = [rules[ptr[0] + ptr[1][0]], swap]
      ptr = swap
   end
}
template = list.flatten.join

puts "1"
allChars = template.chars.uniq
allCharCnt = allChars.zip(allChars.map{|c|template.count(c)}).to_h
puts "10 steps: #{allCharCnt.values.max - allCharCnt.values.min}"

30.times { |i|
   ptr = list
   while(ptr[1][0]!=nil) do
      swap = ptr[1]
      ptr[1] = [rules[ptr[0] + ptr[1][0]], swap]
      ptr = swap
   end
}
puts "2"
template = list.flatten.join
allChars = template.chars.uniq
allCharCnt = allChars.zip(allChars.map{|c|template.count(c)}).to_h
puts "40 steps: #{allCharCnt.values.max - allCharCnt.values.min}"

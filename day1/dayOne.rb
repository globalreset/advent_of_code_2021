inputList = IO.readlines("dayOneInput.txt").collect{ |line| line.to_i }

puts (1...inputList.size).to_a.inject(0) { |sum,i| (inputList[i] > inputList[i-1]) ? sum + 1 : sum }

sums = (2...inputList.size).to_a.collect { |i| inputList[i] + inputList[i-1] + inputList[i-2] }
puts (1...sums.size).to_a.inject(0) { |sum,i| (sums[i]>sums[i-1]) ? sum + 1 : sum }

# adding another solution I saw that solves both in one expression
# 3-element sliding window works because they only differ by first element of first window and
# last element of second window.
[1,3].each { |i|
   puts inputList[0...-i].zip(inputList[i..-1]).count{|x,y| x<y}
}

inputList = IO.readlines("dayOneInput.txt").collect{ |line| line.to_i }

puts (1...inputList.size).to_a.inject(0) { |sum,i| (inputList[i] > inputList[i-1]) ? sum + 1 : sum }

sums = (2...inputList.size).to_a.collect { |i| inputList[i] + inputList[i-1] + inputList[i-2] }
puts (1...sums.size).to_a.inject(0) { |sum,i| (sums[i]>sums[i-1]) ? sum + 1 : sum }
input = IO.readlines("daySevenInput.txt")[0].split(",").collect{ |i| i.to_i }

results = {}
(input.min..input.max).to_a.each { |i|
   cost = input.inject(0) { |sum, a| sum += (i - a).abs }
   results[cost] = i
}
puts "#{results.keys.min} (#{results[results.keys.min]})"

results = {}
(input.min..input.max).to_a.each { |i|
   cost = input.inject(0) { |sum, a| 
      #c = 0
      #(i - a).abs.times { |i| c += i+1 }
      #sum += c 
      n = (i - a).abs
      sum += n*(n+1)/2
   }
   results[cost] = i
}
puts "#{results.keys.min} (#{results[results.keys.min]})"
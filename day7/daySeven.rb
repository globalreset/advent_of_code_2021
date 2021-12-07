input = IO.readlines("daySevenInput.txt")[0].split(",").collect{ |i| i.to_i }

results = {}
(input.min..input.max).to_a.each { |i|
   cost = input.inject(0) { |sum, a| sum += (i - a).abs }
   results[cost] = i
}
puts "#{results.keys.min} (#{results[results.keys.min]})"

#cache = {}
results = {}
(input.min..input.max).to_a.each { |i|
   cost = input.inject(0) { |sum, a| 
      n = (i - a).abs
      # first attempt, rather brute forcey
      #c = 0
      #n.times { |i| c += i+1 }
      #sum += c 
      
      # testing same brute force but caching results
      #if(cache[n]==nil)
      #   c = 0
      #   n.times { |i| c += i + 1 }
      #   cache[n] = c
      #end
      #sum += cache[n] 

      # just use formula for simple summation, einstein
      sum += n*(n+1)/2
   }
   results[cost] = i
}
puts "#{results.keys.min} (#{results[results.keys.min]})"
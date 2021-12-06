input = IO.readlines("dayThreeInput.txt").collect { |i| i.chomp.split('').collect{ |j| j.to_i } }

moreOnes = input.transpose.collect { |i| (i.sum(0.0)/i.size).round(0) }

gamma = 0
moreOnes.each_index { |i|
   gamma <<= 1
   gamma += 1 if(moreOnes[i]==1)
}
puts gamma * ((~gamma) & ((1<<moreOnes.size) -1))

bitPos = 0
o2 = input.clone
co2 = input.clone
moreOnes.each_index { |bitPos|
   moreOnesO2 = o2.transpose.collect { |i| (i.sum(0.0)/i.size).round(0) }
   if(o2.size>1)
      o2 = o2.collect { |i| moreOnesO2[bitPos]==i[bitPos] ? i : nil }.compact
   end
   moreOnesCO2 = co2.transpose.collect { |i| (i.sum(0.0)/i.size).round(0) }
   if(co2.size>1)
      co2 = co2.collect { |i| moreOnesCO2[bitPos]==i[bitPos] ? nil : i }.compact
   end
}

puts o2[0].collect {|i| "#{i}" }.reduce(:+).to_i(2)  * co2[0].collect {|i| "#{i}" }.reduce(:+).to_i(2)
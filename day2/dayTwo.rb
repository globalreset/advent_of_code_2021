input = IO.readlines("dayTwoInput.txt").collect{ |line| line.split(" ") }.collect { |a| [a[0], a[1].to_i] }

pos = [0,0]
input.each { |i|
   case(i[0])
   when "forward"
      pos[0] += i[1]
   when "down"
      pos[1] += i[1]
   when "up"
      pos[1] -= i[1]
   end
}

puts pos[0]*pos[1]


pos = [0,0,0]

input.each { |i|
   case(i[0])
   when "forward"
      pos[0] += i[1]
      pos[1] += i[1]*pos[2]
   when "down"
      pos[2] += i[1]
   when "up"
      pos[2] -= i[1]
   end
}
puts pos[0]*pos[1]
input = "target area: x=206..250, y=-105..-57"

input =~ /x=(.*)\.\.(.*), y=(.*)\.\.(.*)/
targetX_min = Regexp.last_match(1).to_i
targetX_max = Regexp.last_match(2).to_i
targetY_min = Regexp.last_match(3).to_i
targetY_max = Regexp.last_match(4).to_i
targetX = targetX_min..targetX_max
targetY = targetY_min..targetY_max

success = {}
all_yHeight = []
(1..targetX_max).to_a.each { |init_xV|
   (-500..500).to_a.each { |init_yV|
      xV = init_xV
      yV = init_yV
      xP = 0
      yP = 0
      yHeight = []
      until(xP>targetX_max || yP<targetY_min) do
         xP += xV
         yP += yV
         yHeight << yP
         if(targetX.include?(xP) && targetY.include?(yP))
            all_yHeight << yHeight
            success["#{init_xV},#{init_yV}"] = true
            break
         end
         xV -= 1 if(xV>0)
         yV -= 1

      end
   }
}

puts all_yHeight.flatten.max
puts success.size

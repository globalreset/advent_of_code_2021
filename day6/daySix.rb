input = IO.readlines("daySixInput.txt")[0].split(",").collect{ |i| i.to_i }

$descendantCache = {}

def descendantCalc(start, days)
   return 1 if(days==0)
   unless($descendantCache.has_key?([start,days]))
      if(start==0)
         $descendantCache[[start,days]] = descendantCalc(8, days-1) + descendantCalc(6, days-1)
      else
         $descendantCache[[start,days]] = descendantCalc(start-1, days-1)
      end
   end
   return $descendantCache[[start,days]]
end

descendantSum = 0
input.each { |i|
   descendantSum += descendantCalc(i, 80)
}
puts "80: size=#{descendantSum}"

descendantSum = 0
input.each { |i|
   descendantSum += descendantCalc(i, 256)
}
puts "256: size=#{descendantSum}"

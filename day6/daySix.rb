input = IO.readlines("daySixInput.txt")[0].split(",").collect{ |i| i.to_i }
$descendantCache = {}

def descendantCalc(start, days)
   if($descendantCache[[start,days]])
      return $descendantCache[[start,days]]
   else
      sum = 0
      if(days>0)
         if(start==0)
            sum = descendantCalc(8, days-1) + descendantCalc(6, days-1)
         else
            sum = descendantCalc(start-1, days-1)
         end
      else
         return 1
      end
      $descendantCache[[start,days]] = sum
      return sum
   end
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

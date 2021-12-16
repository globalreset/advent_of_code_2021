input = IO.readlines("daySixteenInput.txt")[0].chomp

dec = "0x#{input}".to_i(16)
bin = []
(4*input.size).times { |i|
   bin.unshift (dec&0x1)
   dec >>= 1
}


class Array
   def popDec(bitCnt)
      dec = self[0..(bitCnt-1)].map {|i|i.to_s}.join.to_i(2)
      self.slice!(0..(bitCnt-1))
      dec
   end
end

$vSum = 0
def parse(bin, pktCntExp, operator)
   pktCnt = 0
   values = []
   while((pktCntExp==0 || pktCnt < pktCntExp) && bin.size>0)
      pktCnt += 1
      v = bin.popDec(3)
      $vSum += v
      t = bin.popDec(3)
      case t
      when 4 #value
         value = 0
         begin
            more = bin.popDec(1)
            value = (value<<4) + bin.popDec(4)
         end while(more==1)
         values.push value
      else
         lt = bin.popDec(1)
         if(lt==0) #num bits
            bitCnt = bin.popDec(15)
            if(bitCnt>0)
               values.push(parse(bin.slice!(0..(bitCnt-1)), 0, t))
            end
         else #num packets
            numPkt = bin.popDec(11)
            if(numPkt>0)
               values.push(parse(bin, numPkt, t))
            end
         end
         values.flatten!
      end
   end
   case operator
   when 0 #sum
      return values.sum
   when 1
      return values.inject(1,:*)
   when 2
      return values.min
   when 3
      return values.max
   when 4
      return values
   when 5
      return values[0]>values[1]?1:0
   when 6
      return values[0]<values[1]?1:0
   when 7
      return values[0]==values[1]?1:0
   end
end

puts parse(bin, 0, 4 )
puts "$vSum = #{$vSum}"

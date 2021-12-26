input = IO.readlines("dayEighteenInput.txt").map{|line| eval line.chomp}

def calcMagnitude(pairs)
   pairs[0] = calcMagnitude(pairs[0]) if(pairs[0].kind_of?(Array))
   pairs[1] = calcMagnitude(pairs[1]) if(pairs[1].kind_of?(Array))
   return 3*pairs[0] + 2*pairs[1]
end

sumPairs = input.shift
sumPairStr = sumPairs.inspect
begin 
   openIdx = []
   depth = 0
   modified = false
   # search
   sumPairStr.size.times { |idx|
      case sumPairStr[idx]
      when "["
         openIdx.push(idx)
         depth += 1
      when "]"
         start = openIdx.pop
         if(depth>4 && sumPairStr[start..idx] =~ /^\[(\d+), (\d+)\]$/)
            # let's explode
            modified = true
            explodedParts = sumPairStr[(start+1)...idx].split(", ").map{|x|x.to_i}
            leftString = sumPairStr[0...start]
            rightString = sumPairStr[(idx+1)..-1]
            done = false
            leftString = leftString.scan(/(\[)|(\])|( )|(,)|(\d+)/).reverse.map{ |part|
               part = part.compact[0]
               if(!done && part =~ /(\d+)/)
                  done = true
                  Regexp.last_match(1).to_i + explodedParts[0]
               else
                  part
               end
            }.reverse.join
            done = false
            rightString = rightString.scan(/(\[)|(\])|( )|(,)|(\d+)/).map { |part| 
               part = part.compact[0]
               if(!done && part =~ /(\d+)/)
                  done = true
                  Regexp.last_match(1).to_i + explodedParts[1]
               else
                  part
               end
            }.join
            sumPairStr = leftString + "0" + rightString
            break
         end
         depth -= 1
      end
   }
   if(!modified)
      # check for splits
      idx = sumPairStr.index(/\d\d/)
      if(idx)
         value = sumPairStr[idx..(idx+1)].to_i
         sumPairStr = sumPairStr[0...idx] + "[#{value/2}, #{((value+0.5)/2).round}]" + sumPairStr[(idx+2)..-1]
         modified = true
      end
   end
   if(!modified && input.size>0)
      #do the next addition
      sumPairs = [eval(sumPairStr), input.shift]
      sumPairStr = sumPairs.inspect
      modified = true
   end
end while(modified)


puts calcMagnitude(eval(sumPairStr))

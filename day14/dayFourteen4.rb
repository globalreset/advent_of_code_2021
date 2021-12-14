input = IO.readlines("dayFourteenInput.txt").map{|line| line.chomp}

template = input[0]
rules = input[2..-1].map{|c| c.split(" -> ")}.to_h

$cache = {}

def countChars(pair, rules, depth)
   charCnt = {}
   charCnt.default = 0
   if(depth>0)
      charCnt[rules[pair]] += 1
      leftPair = pair.chars[0] + rules[pair] 
      leftKey = "#{leftPair}#{depth-1}"
      if($cache[leftKey]==nil)
         $cache[leftKey] = countChars(leftPair, rules, depth-1)
      end
      $cache[leftKey].keys.each { |k|
         charCnt[k] += $cache[leftKey][k]
      }
      rightPair = rules[pair] + pair.chars[1]
      rightKey = "#{rightPair}#{depth-1}"
      if($cache[rightKey]==nil)
         $cache[rightKey] = countChars(rightPair, rules, depth-1)
      end
      $cache[rightKey].keys.each { |k|
         charCnt[k] += $cache[rightKey][k]
      }
   end
   return charCnt
end

charCnt = {}
charCnt.default = 0
template.chars.each_cons(2) { |p|
   charCnt[p[0]] += 1
   pairCnt = countChars(p.join, rules, 10)
   pairCnt.keys.each { |k|
      charCnt[k] += pairCnt[k]
   }
}
charCnt[template.chars[-1]] += 1
puts "10 steps: #{charCnt.values.max - charCnt.values.min}"


charCnt = {}
charCnt.default = 0
template.chars.each_cons(2) { |p|
   charCnt[p[0]] += 1
   pairCnt = countChars(p.join, rules, 40)
   pairCnt.keys.each { |k|
      charCnt[k] += pairCnt[k]
   }
}
charCnt[template.chars[-1]] += 1
puts "40 steps: #{charCnt.values.max - charCnt.values.min}"
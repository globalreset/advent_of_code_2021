input = IO.readlines("dayEightInput.txt")

digitCnt = {}
digitCnt.default = 0
input.each { |line|
   line.split(" | ")[1].split(" ").each { |word|
      if(word.size==2)
         digitCnt[1] += 1
      elsif(word.size==4)
         digitCnt[4] += 1
      elsif(word.size==3)
         digitCnt[7] += 1
      elsif(word.size==7)
         digitCnt[8] += 1
      end
   }
}
puts digitCnt.values.inject(0, :+)


sum = 0
input.each { |line|
   digit = {}
   i,o = line.split(" | ").map{|w| w.split(" ")}
 
   digit[1] = i.find { |word| word.size==2 }.chars.sort.join
   digit[4] = i.find { |word| word.size==4 }.chars.sort.join
   digit[7] = i.find { |word| word.size==3 }.chars.sort.join
   digit[8] = i.find { |word| word.size==7 }.chars.sort.join

   # 9 is only 6 segment digit that contains all same segments as 4
   digit[9] = i.find { |word|
      word.size == 6 && digit[4].chars.inject(true) { |andSum, c| 
         andSum = andSum && word.include?(c)
      }
   }.chars.sort.join
   # remove 9
   i = i.collect { |word| word.chars.sort.join==digit[9] ? nil : word }.compact

   # after removing 9, 0 is only 6 segment digit that contains all same segments as 1
   digit[0] = i.find { |word|
      word.size == 6 && digit[1].chars.inject(true) { |andSum, c| 
         andSum = andSum && word.include?(c)
      }
   }.chars.sort.join
   # remove 0
   i = i.collect { |word| word.chars.sort.join==digit[0] ? nil : word }.compact
  
   # after removing 9 and 0, 6 is only 6 segment digit left
   digit[6] = i.find { |word| word.size==6 }.chars.sort.join

   # we now have enough info to calculate all the segment positions
   a = digit[7].delete(digit[1])
   c = digit[0].delete(digit[6])
   d = digit[4].delete(digit[0])
   e = digit[8].delete(digit[9])
   f = digit[1].delete(c)
   g = digit[9].delete(digit[4]).delete(digit[7])
   b = digit[0].delete(digit[7]).delete(e).delete(g)

   lookup = {}
   lookup[[a,b,c,e,f,g].sort.join] = 0
   lookup[[c,f].sort.join] = 1
   lookup[[a,c,d,e,g].sort.join] = 2
   lookup[[a,c,d,f,g].sort.join] = 3
   lookup[[b,c,d,f].sort.join] = 4
   lookup[[a,b,d,f,g].sort.join] = 5
   lookup[[a,b,d,e,f,g].sort.join] = 6
   lookup[[a,c,f].sort.join] = 7
   lookup[[a,b,c,d,e,f,g].sort.join] = 8
   lookup[[a,b,c,d,f,g].sort.join] = 9

   sum += o.map{|word| lookup[word.chars.sort.join].to_s}.join.to_i
}

puts sum


# documenting a "simpler" solution I found from the list of top finishers for the day
require 'set'

sum = 0
input.each { |line|
   i,o = line.split(" | ")
   # whatever mapping of segments is found, these are the required digits in order
   d = ["abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"]
   req = Set.new(d)
   "abcdefg".chars.permutation { |x| 
      # use permutations of the full list of segments to create every possible segment map
      testMap = Hash[x.zip("abcdefg".chars)]
      # map the characters in the input string using segment map
      testInput = Set.new(i.split(" ").map{ |c| c.chars.map{ |e| testMap[e] }.sort.join } )
      # check to see if this gave us the full set of consistent characters
      if(req == testInput)
         # map output using test map and find ordinal value
         sum += o.split(" ").map{ |w| w.chars.map{ |e| testMap[e] }.sort.join }.map { |w| d.find_index(w) }.join.to_i
         break
      end
   }
}
puts sum
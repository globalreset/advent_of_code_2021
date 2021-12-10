input = IO.readlines("dayTenInput.txt").map{|line| line.chomp }

symbolHash = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
valueHash = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
score = []
incompleteLines = []
input.each { |line|
   open = []
   line.chars.each { |c|
      if(symbolHash.values.include?(c))
         if(open.size==0 || symbolHash[open.shift]!=c)
            score <<= valueHash[c]
            open = []
            break
         end
      elsif(symbolHash.keys.include?(c))
         open.unshift c
      end
   }
   if(open.size>0)
      incompleteLines <<= open
   end
}
puts score.sum

puts incompleteLines.map { |open|
   open.inject(0) { |acc, c| acc = 5*acc + 1 + symbolHash.keys.find_index(c) }
}.sort[incompleteLines.size/2]

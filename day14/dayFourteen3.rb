input = IO.readlines("dayFourteenInput.txt").map{|line| line.chomp}

template = input[0]
rules = input[2..-1].map{|c| c.split(" -> ")}.to_h

def countChars(pair, rules, depth, charCnt)
   if(depth>0)
      charCnt[rules[pair.join]] += 1
      countChars([pair[0],rules[pair.join]], rules, depth - 1, charCnt)
      countChars([rules[pair.join],pair[1]], rules, depth - 1, charCnt)
   end
end

charCnt = {}
charCnt.default = 0
template.chars.each_cons(2) { |p|
   charCnt[p[0]] += 1
   countChars(p, rules, 10, charCnt)
}
charCnt[template.chars[-1]] += 1
puts "10 steps: #{charCnt.values.max - charCnt.values.min}"


charCnt = {}
charCnt.default = 0
template.chars.each_cons(2) { |p|
   charCnt[p[0]] += 1
   countChars(p, rules, 40, charCnt)
}
charCnt[template.chars[-1]] += 1
puts "40 steps: #{charCnt.values.max - charCnt.values.min}"
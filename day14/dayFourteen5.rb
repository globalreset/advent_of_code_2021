input = IO.readlines("dayFourteenInput.txt").map{|line| line.chomp}

template = input[0]
rules = input[2..-1].map{|c| c.split(" -> ")}.to_h

pairCnt = {}
pairCnt.default = 0
template.chars.each_cons(2) { |p|
   pairCnt[p.join] += 1
}

40.times {
   newCnt = {}
   newCnt.default = 0
   pairCnt.keys.each { |k|
      newCnt[k.chars[0] + rules[k]] += pairCnt[k]
      newCnt[rules[k] + k.chars[1]] += pairCnt[k]
   }
   pairCnt = newCnt
}

letterCnt = {}
letterCnt.default = 0
pairCnt.keys.each{ |k| letterCnt[k.chars[0]] += pairCnt[k] }
letterCnt[template[-1]] += 1

puts "40 steps: #{letterCnt.values.max - letterCnt.values.min}"

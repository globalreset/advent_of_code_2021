input = IO.readlines("dayFourteenInput.txt").map{|line| line.chomp}

#input2 = [
#   "NNCB",
#   "",
#   "CH -> B",
#   "HH -> N",
#   "CB -> H",
#   "NH -> C",
#   "HB -> C",
#   "HC -> B",
#   "HN -> C",
#   "NN -> C",
#   "BH -> H",
#   "NC -> B",
#   "NB -> B",
#   "BN -> B",
#   "BB -> N",
#   "BC -> B",
#   "CC -> N",
#   "CN -> C"
#]

template = input[0]
rules = input[2..-1].map{|c| c.split(" -> ")}.to_h

puts template
10.times { |i|
   template = template.chars.each_cons(2).map { |p|
     p[0] + rules[p.join] 
   }.join + template.chars[-1]
}

puts "1"
allChars = template.chars.uniq
allCharCnt = allChars.zip(allChars.map{|c|template.count(c)}).to_h
puts "10 steps: #{allCharCnt.values.max - allCharCnt.values.min}"

30.times { |i|
   template = template.chars.each_cons(2).map { |p|
     p[0] + rules[p.join] 
   }.join + template.chars[-1]
}
puts "2"
allChars = template.chars.uniq
allCharCnt = allChars.zip(allChars.map{|c|template.count(c)}).to_h
puts "40 steps: #{allCharCnt.values.max - allCharCnt.values.min}"
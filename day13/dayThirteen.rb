input = IO.readlines("dayThirteenInput.txt").map{|line| line.chomp}

dots = input.select{ |x| x=~ /[0-9]+,[0-9]+/ }.map{|line| line.split(",")}.map{|x,y| [x.to_i, y.to_i]}
folds = input.select{ |x| x=~ /fold along/ }.map{|line| line.split(" ")[-1].split("=")}.map{|a,b| [a,b.to_i]}

hashGrid = {}
xMax = dots.transpose[0].max
yMax = dots.transpose[1].max
(0..yMax).each {|y|
  hashGrid[y] = Array.new(xMax+1, 0)
}
dots.each{ |x,y|
   hashGrid[y][x] = 1
}

folds.each{ |axis, index|
   if(axis=="y")
      len = yMax - index 
      len.times { |i|
         (xMax+1).times{|x| hashGrid[index - i - 1][x] |= hashGrid[index + i + 1][x] }
         hashGrid.delete(index+i+1)
      }
      hashGrid.delete(index)
      yMax -= len + 1
   end
   if(axis=="x")
      len = xMax - index 
      hashGrid.keys.each{ |k|
         len.times { |i| hashGrid[k][index - i - 1] |= hashGrid[k][index + i + 1] }
         hashGrid[k] = hashGrid[k][0...index]
      }
      xMax -= len + 1
   end
   puts hashGrid.values.map{|k| k.sum }.sum
}
puts "current output"
hashGrid.keys.each { |k|
   puts hashGrid[k].map{|i| (i==1)?"#":"."}.join
}
input = IO.readlines("dayFiveInput.txt")

input.collect! { |line|
   if(line =~ /(\d+),(\d+) -> (\d+),(\d+)/)
      x1 = Regexp.last_match(1).to_i
      y1 = Regexp.last_match(2).to_i
      x2 = Regexp.last_match(3).to_i
      y2 = Regexp.last_match(4).to_i
      [x1,y1,x2,y2]
   else
      puts "ERRROR"
      exit
   end
}

grid = {}
grid.default = 0
maxX = 0
maxY = 0
input.each { |x1,y1,x2,y2| 
   maxX = [maxX,x1,x2].max
   maxY = [maxY,y1,y2].max
   if(x1==x2) # vertical line
      ([y1,y2].min..[y1,y2].max).to_a.each{ |y|
         grid[[x1,y]] += 1
      }
   elsif(y1==y2) # horizontal line
      ([x1,x2].min..[x1,x2].max).to_a.each{ |x|
         grid[[x,y1]] += 1
      }
   end
}

cnt = 0
(maxY+1).times { |y|
   (maxX+1).times { |x|
      cnt += 1 if(grid[[x,y]]>=2)
   }
}
puts cnt

input.each { |x1,y1,x2,y2| 
   if(x1!=x2 && y1!=y2) # diagonal line
      xs = (x2>x1) ? (x1..x2).to_a : (x2..x1).to_a.reverse
      ys = (y2>y1) ? (y1..y2).to_a : (y2..y1).to_a.reverse
      [xs,ys].transpose.each{ |pair| grid[pair] += 1 }
   end
}

cnt = 0
(maxY+1).times { |y|
   (maxX+1).times { |x|
      cnt += 1 if(grid[[x,y]]>=2)
   }
}
puts cnt
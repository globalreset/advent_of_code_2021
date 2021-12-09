input = IO.readlines("dayNineInput.txt").map{|line| line.chomp.chars.map{ |c| c.to_i } }

list = []
sum = 0
input.size.times { |y|
   input[y].size.times { |x|
      if( (y==0 || input[y][x]<input[y-1][x]) && 
          (x==0 || input[y][x]<input[y][x-1]) && 
          (y==input.size-1 || input[y][x]<input[y+1][x]) && 
          (x==input[y].size-1 || input[y][x]<input[y][x+1]) )
         sum += 1 + input[y][x] 
         list <<= [y,x]
      end
   } 
}
puts sum

def calcBasin(input, y, x, visited)
   if(visited[[y,x]] || y<0 || y>input.size-1 || x<0 || x>input[y].size-1 || input[y][x] == 9)
      return 0
   else
      visited[[y,x]] = true
      return 1 + 
         calcBasin(input, y+1, x, visited) + 
         calcBasin(input, y-1, x, visited) + 
         calcBasin(input, y, x+1, visited) + 
         calcBasin(input, y, x-1, visited)
   end
end

basinSizes = []
list.each { |y,x|
   visited = {}
   visited.default = false
   basinSizes << calcBasin(input, y, x, visited)
}
puts basinSizes.sort[-3..-1].inject(:*)
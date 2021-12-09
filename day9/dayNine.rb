input = IO.readlines("dayNineInput.txt").map{|line| line.chomp.chars.map{ |c| c.to_i } }

list = []
sum = 0
input.size.times { |y|
   input[y].size.times { |x|
      smallestNeighbor = [[y+1,x], [y-1,x], [y,x+1], [y,x-1]].map { |a,b| 
         if((0...input.size).include?(a) && (0...input[a].size).include?(b)) 
            input[a][b] 
         end
      }.compact.min
      if(input[y][x] < smallestNeighbor)
         list <<= [y,x]
      end
   } 
}

puts list.map { |y,x| input[y][x] }.sum + list.size

def calcBasin(input, y, x, visited)
   if(visited[[y,x]] || input[y][x] == 9)
      return 0
   else
      visited[[y,x]] = true
      return 1 + 
         [[y+1,x], [y-1,x], [y,x+1], [y,x-1]].map { |a,b| 
            if((0...input.size).include?(a) && (0...input[a].size).include?(b)) 
               calcBasin(input, a, b, visited) 
            end
         }.compact.sum
   end
end

puts list.map { |y,x| calcBasin(input, y, x, {}) }.sort[-3..-1].inject(:*)
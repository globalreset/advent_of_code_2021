input = IO.readlines("dayElevenInput.txt").map{|line| line.chomp.chars.map {|c| c.to_i} }

def flashNeighbors(input, coord, flashed)
   [[-1,-1],[-1,0],[-1,1],
    [ 0,-1],       [ 0,1],
    [ 1,-1],[ 1,0],[ 1,1]].each { |offset|
      offset = [offset,coord].transpose.map{|o| o.inject(:+)}
      if((0...input.size).include?(offset[0]) && (0...input[offset[0]].size).include?(offset[1]) && !flashed[offset])
         input[offset[0]][offset[1]] = (input[offset[0]][offset[1]] + 1) % 10
         if(input[offset[0]][offset[1]]==0)
            flashed[offset] = true
            flashNeighbors(input, offset, flashed)
         end
      end
   }
end

step = 0
flashCnt = 0
loop do
   flashed = {}
   input.size.times { |y|
      input[y].size.times { |x|
         if(!flashed[[y,x]])
            input[y][x] = (input[y][x] + 1) % 10
            if(input[y][x]==0)
               flashed[[y,x]] = true
               flashNeighbors(input, [y, x], flashed)
            end
         end
      }
   }
   step += 1
   flashCnt += flashed.size
   if(step==100)
      puts flashCnt
   end
   if(flashed.size==(input.size*input[0].size))
      puts step
      break
   end
end
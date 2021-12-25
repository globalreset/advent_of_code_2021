input = IO.readlines("dayTwentyFiveInput.txt").map{|l|l.chomp.chars}

maxX = input[0].size
maxY = input.size
moved = true
stepCnt = 0
while(moved) do
   moved = false
   stepCnt += 1
   input = input.map{ |line| 
      newLine = []
      maxX.times{ |i| 
         newLine[i] ||= line[i]
         if(line[i]==">" && line[(i+1)%maxX]==".")
            newLine[i] = "."
            newLine[(i+1)%maxX] = ">"
            moved = true
         end
      }
      newLine
   }
   input = input.transpose.map{ |line| 
      newLine = []
      maxY.times{ |i| 
         newLine[i] ||= line[i]
         if(line[i]=="v" && line[(i+1)%maxY]==".")
            newLine[i] = "."
            newLine[(i+1)%maxY] = "v"
            moved = true
         end
      }
      newLine
   }.transpose
end

puts stepCnt
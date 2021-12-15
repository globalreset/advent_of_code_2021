# borrowing an efficient priority queue implementation so I can turn
# my naive search into Dijkstra's
require '../util/pqueue'

input = IO.readlines("dayFifteenInput.txt").map{|line| line.chomp}

$risk = input.map {|l| l.chars.map{ |c| c.to_i}}
$rows = $risk.size
$cols = $risk[0].size
$fullRows = $rows
$fullCols = $cols

def getCost(neighbor)
   x,y = neighbor.split(",").map{|p|p.to_i}
   ($risk[y%$rows][x%$cols] + x/$cols + y/$rows - 1) % 9 + 1
end

def getNeighbors(current)
   x,y = current.split(",").map{|p|p.to_i}
   neighbors = []
   return [[x+1,y],[x-1,y],[x,y+1],[x,y-1]].map { |x2,y2|
      if(x2>=0 && x2<$fullCols && y2>=0 && y2<$fullRows)
         "#{x2},#{y2}"
      end
   }.compact
end

def printPath(start, goal, pathHash)
   pathStr = goal
   until(goal==start)
      pathStr += "<=#{cameFrom[goal]}"
      goal = cameFrom[goal]
   end
end

def search(start, goal) 
   inf = 1/0.0
   pathHash = {}
   pathScore = {}
   pathScore.default = inf
   pathScore[start] = 0
   pqueue = PQueue.new([start]) {|a,b| pathScore[b]<=>pathScore[a]}
   while(!pqueue.empty?) do
      current = pqueue.peek
      if(current==goal)
         #printPath(start, goal, pathHash)
         return pathScore[current]
      end
      pqueue.pop
      getNeighbors(current).each { |n|
         newPathScore = pathScore[current] + getCost(n)
         if(newPathScore < pathScore[n])
            pathHash[n] = current
            pathScore[n] = newPathScore 
            if(!pqueue.include?(n))
               pqueue.push(n)
            end
         end
      }
   end
end

puts search("0,0", "#{$fullRows-1},#{$fullCols-1}")

$fullRows = $rows * 5
$fullCols = $cols * 5

puts search("0,0", "#{$fullRows-1},#{$fullCols-1}")

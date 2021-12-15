class Hash
  def method_missing(sym,*args)
    if(sym[-1]=="=")
       self.store(sym[0...-1].to_sym, args[0])
    else
       self.fetch(sym.to_sym)
    end
  end
end


require_relative 'pqueue'

class DijkstraSearch
   Infinity = 1/0.0

   def initialize(neighborHash, costHash)
      @neighborHash = neighborHash
      @costHash = costHash
      @pathHash = {}
      @pathScore = {}
      @pathScore.default = Infinity
   end
   
   def printPath(start, goal)
      pathStr = goal
      until(goal==start)
         pathStr += "<=#{pathHash[goal]}"
         goal = pathHash[goal]
      end
   end

   # generic dijkstra's search
   def search(start, goal)
      @pathHash = {}
      @pathScore = {}
      @pathScore.default = Infinity
      @pathScore[start] = 0
      pqueue = PQueue.new([start]) {|a,b| @pathScore[b]<=>@pathScore[a]}
      while(!pqueue.empty?) do
         current = pqueue.pop
         if(current==goal)
            return @pathScore[current]
         end
         @neighborHash[current].each { |n|
            newPathScore = @pathScore[current] + @costHash[n]
            if(newPathScore < @pathScore[n])
               @pathHash[n] = current
               @pathScore[n] = newPathScore 
               if(!pqueue.include?(n))
                  pqueue.push(n)
               end
            end
         }
      end
      return nil
   end
end
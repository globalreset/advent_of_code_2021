class Hash
  def method_missing(sym,*args)
    if(sym[-1]=="=")
       self.store(sym[0...-1].to_sym, args[0])
    else
       self.fetch(sym.to_sym)
    end
  end
end


# generic dijkstra's search
# getCost and getNeighbors must be implemented for the graph
#def getCost(neighbor)
#  return xyz
#end
#def getNeighbors(current)
#   return [a,b,c]
#end
def search(start, goal) 
   inf = 1/0.0
   pathHash = {}
   pathScore = {}
   pathScore.default = inf
   pathScore[start] = 0
   pqueue = [start]
   while(!pqueue.empty?) do
      current = pqueue.pop
      if(current==goal)
         #printPath(start, goal, pathHash)
         return pathScore[current]
      end
      getNeighbors(current).each { |n|
         newPathScore = pathScore[current] + getCost(n)
         if(newPathScore < pathScore[n])
            pathHash[n] = current
            pathScore[n] = newPathScore 
            if(!pqueue.include?(n))
               pqueue.push(n)
               # this is pretty slow for the bigger version
               pqueue.sort! {|a,b| pathScore[b]<=>pathScore[a]}
            end
         end
      }
   end
end
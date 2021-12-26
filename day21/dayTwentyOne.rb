
pos = [7,1]
score = [0,0]

player = 1
die = 0
rollCnt = 0
while(score.max<1000) do
   player ^= 1
   3.times { |i|
      rollCnt += 1
      die += 1
      die = 1 if(die>100)
      pos[player] = (pos[player]-1+die)%10 + 1
   }
   score[player] += pos[player]
   puts "Player: #{player+1}, pos=#{pos.inspect}, score=#{score.inspect}"
end
puts score.min*rollCnt


winCnt = [0,0]
games = {}
games.default = 0
games[[[7,1],[0,0],0]] = 1
while(games.size>0)
   games.keys.each { |g|
      gameCnt = games.delete(g)
      pos, score, player = g
      (1..3).each{ |i|
         (1..3).each{ |j|
            (1..3).each{ |k|
               newPos = pos+[]
               newPos[player] = (newPos[player]+i+j+k-1)%10 + 1
               newScore = score+[]
               newScore[player] += newPos[player]
               if(newScore[player]>=21)
                  winCnt[player] += gameCnt
               else
                  games[[newPos, newScore, player^1]] += gameCnt
               end
            }
         }
      }
   }
end
puts winCnt.max

$allNodes = {}
IO.readlines("dayTwelveInput.txt").map{|line| line.chomp.split("-")}.each { |line|
   ($allNodes[line[0]] ||= []).push(line[1])
   ($allNodes[line[1]] ||= []).push(line[0])
}

$lowerCaseNodes = $allNodes.keys.select{|k| k=~/[a-z]/}

def countPaths(node, path)
   return $allNodes[node].select{|n| n!="start"}.map { |n|
      if(n=="end")
         1
      elsif(!$lowerCaseNodes.include?(n) || path.count(n)==0)
         countPaths(n, path + [n])
      end
   }.compact.inject(:+)
end

puts countPaths("start", [])


def countPaths2(node, path)
   cntHash = $lowerCaseNodes.zip($lowerCaseNodes.map{|n| path.count(n)}).to_h
   return $allNodes[node].select{|n| n!="start"}.map { |n|
      if(n=="end")
         1
      elsif(cntHash[n]==nil || cntHash[n]==0 || (cntHash[n]>0 && !cntHash.values.include?(2)) )
         countPaths2(n, path + [n])
      end
   }.compact.inject(:+)
end

puts countPaths2("start",  ["start"])









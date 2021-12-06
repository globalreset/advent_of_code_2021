input = IO.readlines("dayFourInput.txt")

numbers = input[0].split(",").collect { |i| i.to_i }
boardCnt = (input.size-1)/6
boards = []
boardWins = []
boardCnt.times { |boardIndex|
   board = []
   5.times { |row|
      if(input[6*boardIndex + row + 2] =~ /(\d+) +(\d+) +(\d+) +(\d+) +(\d+)/)
         board <<= [Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3), Regexp.last_match(4), Regexp.last_match(5)].collect {|i| i.to_i}
      end
   }
   boards <<= board
   boardWins[boardIndex] = [
      board.collect { |row| row.collect { |p| numbers.index(p) }.max },
      board.transpose.collect { |col| col.collect { |p| numbers.index(p) }.max }
   ].flatten.min
}

finalNumberIndex = boardWins.min
winningBoard = boards[boardWins.index(finalNumberIndex)].flatten
(finalNumberIndex+1).times { |i|
   winningBoard.delete(numbers[i])
}
puts winningBoard.sum(0) * numbers[finalNumberIndex]

finalNumberIndex = boardWins.max
winningBoard = boards[boardWins.index(finalNumberIndex)].flatten
(finalNumberIndex+1).times { |i|
   winningBoard.delete(numbers[i])
}
puts winningBoard.sum(0) * numbers[finalNumberIndex]
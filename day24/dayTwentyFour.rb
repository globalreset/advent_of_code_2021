input = IO.readlines("dayTwentyFourInput.txt").map{|line| line.chomp.split(" ")}

# try to reverse engineer what program is doing
#digitIdx = 0
#reg = {}
#input.each { |cmd|
#   puts cmd.inspect
#   if(cmd==["mul", "y", "x"])
#      #this is always a no-op
#   elsif(cmd==["add", "z", "y"])
#      #this is always putting the last digit in the z%26 space
#      reg["digitStack"] = reg["y"]
#   elsif(cmd==["mod", "x", "26"])
#      #this is always getting the last digit out of the z%26 space
#      reg["x"] = reg["digitStack"] || "0"
#   else
#      arg = 0
#      if(cmd.size==3)
#         if(cmd[2] =~ /[a-z]/)
#            arg = reg[cmd[2]]||"0"
#         else
#            arg = cmd[2]
#         end
#      end
#
#      case(cmd[0])
#      when "inp"
#         reg[cmd[1]] = "d#{digitIdx}"
#         digitIdx += 1
#      when "add"
#         if(reg[cmd[1]]==nil || reg[cmd[1]]=="0")
#            reg[cmd[1]] = arg
#         elsif(arg!="0")
#            if(reg[cmd[1]]=~/^[0-9]+$/ && arg=~/^[0-9]+$/)
#               reg[cmd[1]] = (reg[cmd[1]].to_i + arg.to_i).to_s
#            else
#               reg[cmd[1]] = "(#{reg[cmd[1]]}+#{arg})"
#            end
#         end
#      when "mul"
#         if(reg[cmd[1]]==nil || reg[cmd[1]]=="0" || arg=="0")
#            reg[cmd[1]] = "0"
#         elsif(arg!="1")
#            reg[cmd[1]] = "(#{reg[cmd[1]]}*#{arg})"
#         end
#      when "div"
#         if(reg[cmd[1]]==nil || reg[cmd[1]]=="0")
#            reg[cmd[1]] = "0"
#         elsif(arg!="1")
#            reg[cmd[1]] = "(#{reg[cmd[1]]}/#{arg})"
#         end
#      when "mod"
#         if(reg[cmd[1]]==nil || reg[cmd[1]]=="0")
#            reg[cmd[1]] = "0"
#         else
#            reg[cmd[1]] = "(#{reg[cmd[1]]}%#{arg})"
#         end
#      when "eql"
#         if(reg[cmd[1]]=~/^digit[0-9]+$/ && arg=~/^[0-9]+$/ && (arg.to_i>9 || arg.to_i==0))
#            reg[cmd[1]] = "0"
#         elsif(arg=~/^digit[0-9]+$/ && reg[cmd[1]]=~/^[0-9]+$/ && (reg[cmd[1]].to_i>9 || reg[cmd[1]].to_i==0))
#            reg[cmd[1]] = "0"
#         elsif(reg[cmd[1]]==arg)
#            reg[cmd[1]] = "1"
#         else
#            reg[cmd[1]] = "(#{reg[cmd[1]]}==#{arg})"
#         end
#      end
#   end
#   puts reg.inspect
#}

def runProgram(program, inputDigits)
   reg = {}
   reg.default = 0
   #puts inputDigits.inspect
   program.each { |cmd|
      #puts cmd.inspect
      arg = 0
      if(cmd.size>=3)
         if(cmd[2] =~ /[a-z]/)
            arg = reg[cmd[2]]
         else
            arg = cmd[2].to_i
         end
      end

      case(cmd[0])
      when "inp"
         reg[cmd[1]] = inputDigits.shift
      when "add"
         reg[cmd[1]] += arg
      when "mul"
         reg[cmd[1]] *= arg
      when "div"
         reg[cmd[1]] /= arg
      when "mod"
         reg[cmd[1]] %= arg
      when "eql"
         reg[cmd[1]] = (reg[cmd[1]] == arg) ? 1 : 0
      end
      #puts reg.inspect
   }

   return reg["z"]
end

# brute force doesn't work
#MAX = 99_999_999_999_999
#MIN = 11_111_111_111_111
#(MAX-MIN+1).times { |i|
#   puts (MAX-i)
#   if(i.to_s !=~ /0/)
#      inputDigits = (MAX - i).to_s.chars.map {|c| c.to_i }
#      runProgram(input, inputDigits)
#   end
#}

#final z
#(((((((((((((((((((((((((((((((((
#   (d0+8)*26)+       
#   (d1+13))*26)+     
#   (d2+8))*26)+      
#   (d3+10))/26)*26)+ 
#   (d4+12))/26)*26)+  #pop
#   (d5+1))*26)+       #pop
#   (d6+13))*26)+     
#   (d7+5))/26)*26)+  
#   (d8+10))/26)*26)+  #pop
#   (d9+3))*26)+       #pop
#   (d10+2))/26)*26)+
#   (d11+2))/26)*26)+  #pop
#   (d12+12))/26)*26)+ #pop
#   (d13+7))           #pop
#d0 + 8
#d1 + 13
#d2 + 8
#d3 + 10
#check(d4==d3-1)
#check(d5==d2-5)
#d6 + 13
#d7 + 5
#check(d8==d7+3)
#check(d9==d6+7)
#d10 + 2
#check(d11=d10+2)
#check(d12==d1-2)
#check(d13==d0+4)

solutions = []
(1..5).each { |d0|
   (3..9).each { |d1|
      (6..9).each { |d2|
         (2..9).each { |d3|
            (1..2).each { |d6|
               (1..6).each{ |d7|
                  (1..7).each { |d10|
                     d4 = d3 - 1
                     d5 = d2 - 5
                     d8 = d7 + 3
                     d9 = d6 + 7
                     d11 = d10 + 2
                     d12 = d1 - 2
                     d13 = d0 + 4

                     inputDigits = [d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13]
                     solutions << inputDigits.map{|i|i.to_s}.join.to_i
                     #puts runProgram(input, inputDigits)
                  }
               }
            }
         }
      }
   }
}
puts solutions.max
puts solutions.min
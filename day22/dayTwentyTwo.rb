
require "set" 

Point3D = Struct.new(:x, :y, :z)
class Cuboid
   def initialize(state, corner1, corner2)
      @state = state
      @c1 = corner1
      @c2 = corner2
   end

   def state
      return @state
   end
   def state=(s)
      @state = s
   end

   def c1
      @c1
   end
   def c2
      @c2
   end

   def getVolume
      return (@c2.x - @c1.x)*(@c2.y - @c1.y)*(@c2.z - @c1.z)
   end

   def isValid
      return (@c2.x > @c1.x)&&(@c2.y > @c1.y)&&(@c2.z > @c1.z)
   end

   def getOverlap(cube)
      overlap = Cuboid.new(
         cube.state,
         Point3D.new([@c1.x, cube.c1.x].max, 
                     [@c1.y, cube.c1.y].max, 
                     [@c1.z, cube.c1.z].max),
         Point3D.new([@c2.x, cube.c2.x].min, 
                     [@c2.y, cube.c2.y].min, 
                     [@c2.z, cube.c2.z].min)
      )
      if(overlap.isValid)
         return overlap
      else
         return nil
      end
   end

   def toSet
      points = []
      (c1.x..c2.x).each { |x|
         (c1.y..c2.y).each { |y|
            (c1.z..c2.z).each { |z|
               points << [x,y,7]
            }
         }
      }
      return points.to_set 
   end
end

instructions = []
input = IO.readlines("dayTwentyTwoInput.txt").map{ |line| 
   line = line.chomp.split(" ")
   line[1] =~ /x=(.*),y=(.*),z=(.*)/
   xR = eval(Regexp.last_match(1))
   yR = eval(Regexp.last_match(2))
   zR = eval(Regexp.last_match(3))
   instructions << Cuboid.new(
         (line[0]=="on"),
         Point3D.new(xR.min, yR.min, zR.min),
         Point3D.new(xR.max+1, yR.max+1, zR.max+1)
      )
}

interest = Cuboid.new(false, Point3D.new(-50,-50,-50), Point3D.new(51,51,51))
p1_instructions = instructions.map { |cube| 
   interest.getOverlap(cube) 
}.compact

def run_instructions(instructions)
   placed = []
   volume = 0
   # Reversing is handy, because final ON instruction is last instruction
   # for that region. So all we have to do is remember every cuboid we
   # encountered in reverse order and subtract it's region from the cuboids
   # that came before it. For example, if it ends with a cube on, 
   # nothing could turn that off. If a another cube off comes before, 
   # that's okay because it can't affect what we've already counted. But
   # we must remember it so that any subsequent cubes on we encounter before
   # that have their volume reduced by the off that we know came later and
   # intersected it.
   instructions.reverse.each { |cube|
      if(cube.state)
         overlaps = []
         placed.each{ |placedCube|
            if(overlap = placedCube.getOverlap(cube))
               overlap.state = true
               overlaps << overlap
            end
         }
         volume += cube.getVolume - run_instructions(overlaps)
      end
      placed << cube
   }
   return volume
end
puts run_instructions(p1_instructions)
puts run_instructions(instructions)
exit

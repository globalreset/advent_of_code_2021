cuboids = File.readlines("dayTwentyTwoInput.txt").map do |s|
  s.gsub('x=','').gsub(',y=',' ').gsub(',z=',' ').gsub('..',' ')
end
cuboids = cuboids.map do |s|
  s.gsub('on','1').gsub('off','0')
end
cuboids = cuboids.map do |s|
  s.split.map(&:to_i)
end
#cuboids = cuboids.select { |c| c[1].abs <= 50 } # for part 1

# a cuboid is represented as [+1/-1,xmin,xmax,ymin,ymax,zmin,zmax]
# where +1 is 'added cuboid' and -1 is 'subtracted cuboid'

# return the cuboid at the intersection of cuboids s and t
# if cuboid t is added, the intersection is subtracted, and vice versa
def intersection(s, t)
  mm = [
    ->(a, b) { -b },
    ->(a, b) { [a, b].max },
    ->(a, b) { [a, b].min },
    ->(a, b) { [a, b].max },
    ->(a, b) { [a, b].min },
    ->(a, b) { [a, b].max },
    ->(a, b) { [a, b].min },
  ]
  n = (0...7).map { |i| mm[i].call(s[i], t[i]) }
  return n if n[1] <= n[2] && n[3] <= n[4] && n[5] <= n[6]
  return nil
end

cores = []
cuboids.each do |cuboid|
  toadd = [cuboid] if cuboid[0] == 1 # add cuboid to core if 'on'
  cores.each do |core|
    inter = intersection(cuboid, core)
    toadd += [inter] if inter # if nonempty, add to the core later
  end
  cores << toadd
end

def countoncubes(cores)
  oncount = 0
  cores.each do |c|
    oncount += c[0] * (c[2] - c[1] + 1) * (c[4] - c[3] + 1) * (c[6] - c[5] + 1)
  end
  oncount
end

puts "On cubes: #{countoncubes(cores)}"

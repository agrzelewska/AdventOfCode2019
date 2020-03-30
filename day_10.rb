class AstroidDetector
  include Math
  attr_accessor :input

  def initialize(input)
    @input = input.split(/\n/)
  end

  def asteroids_count
    input.join.count('#')
  end

  def asteroids_coords
    asteroids_coords = []
    input.each_with_index do |line, index|
      line.chars.each_with_index do |a, i|
        asteroids_coords << [i, index] if a == '#'
      end
    end
    asteroids_coords
  end

  def angle(ast, ast1)
    a = (ast[0] - ast1[0]).abs.to_f
    b = (ast[1] - ast1[1]).abs.to_f
    if ast[0] == ast1[0]
      angle = ast[1] > ast1[1] ? 0 : 3.1416   # A : E
    elsif ast[1] == ast1[1]
      angle = ast[0] > ast1[0] ? 4.7124 : 1.5708  # G : C
    elsif ast[0] > ast1[0]
      angle = ast[1] > ast1[1] ? Math.atan(b/a) + 4.7124 : Math.atan(a/b) + 3.1416  # H : F
    else
      angle = ast[1] > ast1[1] ? Math.atan(a/b) : Math.atan(b/a) + 1.5708 # B : D
    end
    return angle
  end

  def detect(ast)
    res = []
    asteroids_coords.each do |ast1|
      res << angle(ast,ast1) if ast != ast1
    end
    {ast => res.uniq.size}
  end

  def result
    @result = []
    asteroids_coords.each { |asteroid| @result << detect(asteroid) }
    @max = @result.map { |x| x.values }.flatten.max
  end

  def best_location
    @result.select { |x| x.key(@max) }.first.keys.flatten
  end

  def asteroid_angles(asteroid)
    res = []
    asteroids_coords.each do |ast|
      res << {ast => angle(asteroid, ast)} if asteroid != ast
    end

    ast_angles = {}
    angles = res.map { |a| a.values }.sort
    angles.each do |angle|
      ast_angles.store(angle.join.to_f, [])
    end

    res.map do |p|
      ast_angles[p.values.join.to_f].push(p.keys)
    end

    ast_angles.transform_keys.with_index do |pos,i|
      puts "#{i}= #{pos}"
    end
    @res_sorted = res.sort_by { |k| k.values }
  end
end

input = File.read('day_10_input.txt')
new = AstroidDetector.new(input)

ast = [13,17]
p new.result
p new.best_location
p new.asteroid_angles(ast)


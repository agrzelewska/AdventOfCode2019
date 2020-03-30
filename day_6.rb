class Orbits_Counter
  attr_reader :input, :all_orbits

  def initialize(input)
    @input = input
  end

  def all_orbits_list
    @all_orbits = {}
    orbits = input.map { |orbit| orbit.split(')') }
    orbits.map { |orbit| all_orbits.merge!( orbit[1] => orbit[0] ) }
    all_orbits
  end

  def calculate_distance(start_point, end_point)
    distance = 0

    until start_point == end_point do
      distance += 1
      start_point = all_orbits.fetch(start_point)
    end

    distance
  end

  def sum_all_distances
    planets = all_orbits_list.keys
    sum = 0

    planets.map { |planet| sum +=  calculate_distance(planet, 'COM') }

    sum
  end

  def find_route(planet, end_point)
    stop_point = all_orbits.fetch(planet)
    route = [planet, stop_point]
    route.concat(find_route(stop_point, end_point)) unless stop_point == end_point
    route
  end

  def find_intersections(planet1, planet2)
    find_route(planet1, 'COM') & find_route(planet2, 'COM')
  end

  def the_nearest_intersection(planet1, planet2)
    find_intersections(planet1, planet2).first
  end

  def distance_between(planet1, planet2)
    sum_all_distances
    intersection_point = the_nearest_intersection(planet1, planet2)
    calculate_distance(planet1, intersection_point) + calculate_distance(planet2, intersection_point)
  end

end


input = File.read("day_6_input.txt").split("\n")
new = Orbits_Counter.new(input)
p new.sum_all_distances
p new.distance_between('PFG', '9FD')

# output day 6
# task 1: 147223
# task 2: 340
class Intcode
  attr_accessor :input

  def initialize(input)
    @input = input
    @instructions = (0...input.size).step(4).map { |i|  input.slice(i, 4) }
  end

  def get_result
    (0..99).each do |noun|
      input[1] = noun
      (0..99).each do |verb|
        input[2] = verb
        @instructions.map do |i|
          instruction_pointer = i[0]
          parameter1 = i[1]
          parameter2 = i[2]
          parameter3 = i[3]

          case instruction_pointer
          when 1
            input[parameter3] = input[parameter1] + input[parameter2]
          when 2
            input[parameter3] = input[parameter1] * input[parameter2]
          end
        end
        return (100 * noun + verb) if input[0] == 19690720
      end
    end
  end
end


input = [1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,10,19,23,2,9,23,27,1,6,27,31,2,31,9,35,1,5,35,39,1,10,39,43,1,10,43,47,2,13,47,51,1,10,51,55,2,55,10,59,1,9,59,63,2,6,63,67,1,5,67,71,1,71,5,75,1,5,75,79,2,79,13,83,1,83,5,87,2,6,87,91,1,5,91,95,1,95,9,99,1,99,6,103,1,103,13,107,1,107,5,111,2,111,13,115,1,115,6,119,1,6,119,123,2,123,13,127,1,10,127,131,1,131,2,135,1,135,5,0,99,2,14,0,0]
#
# outputs od day 2
# task1: 3760627
# task2: 7195
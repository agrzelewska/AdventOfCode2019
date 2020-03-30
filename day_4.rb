class SecureContainer
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def get_result
    input.map { |password| password.to_s.chars }
        .select { |num| num == num.sort}
        # .reject { |b| b.join.squeeze.length == 6}                   #line for task 1
        .select { |num| num.map { |i| num.count(i) }.include?(2)  }   #line for task 2
        .size
  end
end

input = (372304..847060).to_a
new = SecureContainer.new(input)
p new.get_result

# output of day 4
# task 1: 475
# task 2: 297
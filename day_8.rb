class ImageDecoder
  attr_accessor :input
  attr_reader :width, :height

  def initialize(input, width=25, height=6)
    @input = input
    @width = width
    @height = height
    @area = width*height
  end

  def split_in_layers(inp)
    @layers = []
    @layers << inp.slice!(0...@area) until inp.empty?
    @layers
  end

  def count_digits
    @counts = {}
    @layers.each_with_index do |layer,i|
      @counts.merge!(i => {0 => layer.count('0'), 1 => layer.count('1'), 2 => layer.count('2')})
    end
    @counts
  end

  def min_zero
    zeros = []
    @counts.each_pair do |layer, values|
      zeros << [values.fetch(0), layer]
    end
    @min_zero = zeros.min
  end

  def count_val(digit,layer)
    @counts.fetch(layer).fetch(digit)
  end

  def result_first
    layer = @min_zero[1]
    count_val(1, layer) * count_val(2, layer)
  end

  def result_second
    result = []
    n = @layers[0].size
    (0...n).each do |i|
      pixels = []
      @layers.each do |a|
        pixels << [a[i]]
      end
      result << pixels.join.delete('2')[0]
    end

    layers = []
    layers << result.slice!(0...@width) until result.empty?
    layers.map { |a| a.join }
  end
end
input = File.read("day_8_input.txt").split('')
a = ImageDecoder.new(input)
# task 2
a.split_in_layers(input)
p a.result_second

# Output day 8
# task 1: 1485
# task 2: RLAKF

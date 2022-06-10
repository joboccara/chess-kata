class Position
  attr_reader :x, :y
  def self.parse(cell)
    # TODO some validation
    letter, number = cell.split('')
    Position.new(letter.ord - 'a'.ord, number.to_i - 1)
  end

  def to_s
    letter = ('a'.ord + x).chr
    number = y + 1
    "#{letter}#{number}"
  end

  private
  def initialize(x, y)
    @x = x
    @y = y
  end
end
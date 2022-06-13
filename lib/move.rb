class Move
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def horizontal?
    (@to.y - @from.y).abs == 0
  end

  def vertical?
    (@to.x - @from.x).abs == 0
  end

  def diagonal?
    (@to.y - @from.y).abs == (@to.x - @from.x).abs
  end

  def forward?
    @to.y > @from.y
  end

  def distance
    if horizontal?
      (@to.x - @from.x).abs
    elsif vertical?
      (@to.y - @from.y).abs
    elsif diagonal?
      (@to.y - @from.y).abs
    end
  end

  def hovered_positions
    x_direction = @to.x <=> @from.x
    y_direction = @to.y <=> @from.y
    (1...distance).map{ |i| Position.new(@from.x + i * x_direction, @from.y + i * y_direction) }
  end
end

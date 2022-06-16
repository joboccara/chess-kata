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

  def l?
    x_distance = (@to.x - @from.x).abs
    y_distance = (@to.y - @from.y).abs
    [1, 2].include?(x_distance) && x_distance + y_distance == 3
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
    elsif l?
      1
    end
  end

  def hovered_positions
    x_direction = @to.x <=> @from.x
    y_direction = @to.y <=> @from.y
    (1...distance).map{ |i| Position.new(@from.x + i * x_direction, @from.y + i * y_direction) }
  end
end

require_relative 'position'

class Board
  def initialize
    @matrix = Array.new(8).map{ Array.new(8) }
  end

  def content(position)
    @matrix[position.x][position.y]
  end

  private

  def position_piece(cell, piece)
    position = Position.parse(cell)

    if @matrix[position.x][position.y]
      return Outcome.new(false, "Position taken at #{position}")
    end

    @matrix[position.x][position.y] = piece

    Outcome.new(true, nil)
  end
end

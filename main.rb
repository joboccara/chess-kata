#!/usr/bin/env ruby

Outcome = Struct.new(:success, :output)

module CoordinateParser
  def self.parse(coordinate)
    # TODO some validation
    letter, number = coordinate.split('')
    [letter.ord - 'a'.ord, number.to_i - 1]
  end
end

module Mover

  class << self
    def move(board, from, to)
      from_x, from_y = CoordinateParser.parse(from)
      to_x, to_y = CoordinateParser.parse(to)
      piece_at_from = board.content(from)

      unless piece_at_from
        return Outcome.new(false, "No piece at starting position #{from}")
      end

      case piece_at_from.type
      when :pawn
        return Outcome.new(false, 'Invalid move for pawn') if (to_y - from_y) > 2

        return Outcome.new(true, board)
      else
        return Outcome.new(false, "Invalid piece")
      end
    end
  end

end

Piece = Struct.new(:type, :color)
class Board

  def initialize
    @matrix = Array.new(8, Array.new(8))
  end

  def content(coordinate)
    x, y = CoordinateParser.parse(coordinate)
    @matrix[x][y]
  end

  private

  def position_piece(coordinate, piece)
    x, y = CoordinateParser.parse(coordinate)

    if @matrix[x][y]
      return Outcome.new(false, "Position taken at #{x}, #{y}")
    end

    @matrix[x][y] = piece

    Outcome.new(true, nil)
  end


end

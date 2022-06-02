#!/usr/bin/env ruby

Outcome = Struct.new(:success, :output)

Position = Struct.new(:x, :y)

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

module Mover

  class << self
    def move(board, from_cell, to_cell)
      from = Position.parse(from_cell)
      to = Position.parse(to_cell)
      piece_at_from = board.content(from)

      unless piece_at_from
        return Outcome.new(false, "No piece at starting position #{from}")
      end

      case piece_at_from.type
      when :pawn
        authorized_move = if (to.y - from.y) == 1 && to.x == from.x
          board.content(to).nil?
        elsif (to.y - from.y) == 2 && to.x == from.x
          board.content(to).nil? && from.y == 1
        elsif (to.y - from.y) == 1 && (to.x - from.x).abs == 1
          !board.content(to).nil? && board.content(to).color != piece_at_from.color
        else
          false
        end

        return Outcome.new(false, 'Invalid move for pawn') unless authorized_move

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
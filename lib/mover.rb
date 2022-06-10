require_relative 'outcome'
require_relative 'position'

class Move
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

  def hovered_positions
    x_direction = @to.x <=> @from.x
    y_direction = @to.y <=> @from.y
    (1...distance).map{ |i| Position.new(@from.x + i * x_direction, @from.y + i * y_direction) }
  end

  private

  def distance
    if horizontal?
      (@to.x - @from.x).abs
    elsif vertical?
      (@to.y - @from.y).abs
    elsif diagonal?
      (@to.y - @from.y).abs
    end
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
      when :rook
        move = Move.new(from, to)
        return Outcome.new(false, 'Invalid move for rook') unless authorized_move?(:rook, move)

        vacant_trajectory = move.hovered_positions.none?{|position| board.content(position)}
        return Outcome.new(false, 'Cannot move past a piece') unless vacant_trajectory

        ally_piece_on_destination = !board.content(to).nil? && board.content(to).color == piece_at_from.color
        return Outcome.new(false, 'Cannot move to a position with an ally piece') if ally_piece_on_destination

        return Outcome.new(true, board)
      when :bishop
        move = Move.new(from, to)
        return Outcome.new(false, 'Invalid move for bishop') unless authorized_move?(:bishop, move)

        vacant_trajectory = move.hovered_positions.none?{|position| board.content(position)}
        return Outcome.new(false, 'Cannot move past a piece') unless vacant_trajectory

        ally_piece_on_destination = !board.content(to).nil? && board.content(to).color == piece_at_from.color
        return Outcome.new(false, 'Cannot move to a position with an ally piece') if ally_piece_on_destination

        return Outcome.new(true, board)
      else
        return Outcome.new(false, "Invalid piece")
      end
    end
    
    def authorized_move?(piece_type, move)
      case piece_type
      when :rook
        authorized_move = move.horizontal? || move.vertical?
      when :bishop
        authorized_move = move.diagonal?
      end
    end
  end
end


require_relative 'outcome'
require_relative 'position'

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
        horizontal_move = (to.y - from.y).abs == 0
        vertical_move = (to.x - from.x).abs == 0
        authorized_move = horizontal_move || vertical_move
        return Outcome.new(false, 'Invalid move for rook') unless authorized_move

        if horizontal_move
          initial_position, *trajectory, final_position = (from.x..to.x).map{|x| Position.new(x, from.y)}
          vacant_trajectory = trajectory.none?{|position| board.content(position)}
        end

        if vertical_move
          initial_position, *trajectory, final_position = (from.y..to.y).map{|y| Position.new(from.x, y)}
          vacant_trajectory = trajectory.none?{|position| board.content(position)}
        end

        return Outcome.new(false, 'Cannot move past a piece') unless vacant_trajectory

        ally_piece_on_destination = !board.content(final_position).nil? && board.content(final_position).color == piece_at_from.color
        return Outcome.new(false, 'Cannot move to a position with an ally piece') if ally_piece_on_destination

        return Outcome.new(true, board)
      when :bishop
        diagonal_move = (to.y - from.y).abs == (to.x - from.x).abs
        authorized_move = diagonal_move
        return Outcome.new(false, 'Invalid move for bishop') unless authorized_move

        distance = (to.y - from.y).abs
        x_direction = to.x <=> from.x
        y_direction = to.y <=> from.y
        initial_position, *trajectory, final_position = (0..distance).map{ |i| Position.new(from.x + i * x_direction, from.y + i * y_direction) }
        vacant_trajectory = trajectory.none?{|position| board.content(position)}

        return Outcome.new(false, 'Cannot move past a piece') unless vacant_trajectory

        ally_piece_on_destination = !board.content(final_position).nil? && board.content(final_position).color == piece_at_from.color
        return Outcome.new(false, 'Cannot move to a position with an ally piece') if ally_piece_on_destination

        return Outcome.new(true, board)
      else
        return Outcome.new(false, "Invalid piece")
      end
    end
  end
end


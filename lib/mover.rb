require_relative 'move'
require_relative 'outcome'
require_relative 'position'

module Mover
  class << self
    def move(board, from_cell, to_cell)
      from = Position.parse(from_cell)
      to = Position.parse(to_cell)
      piece_at_from = board.content(from)

      return Outcome.new(false, "No piece at starting position #{from}") unless piece_at_from
      return Outcome.new(false, "Invalid piece") unless %i(pawn rook bishop king queen knight).include? piece_at_from.type

      move = Move.new(from, to)
      ally_piece_on_destination = !board.content(to).nil? && board.content(to).color == piece_at_from.color
      return Outcome.new(false, 'Cannot move to a position with an ally piece') if ally_piece_on_destination

      return Outcome.new(false, "Invalid move for #{piece_at_from.type}") unless authorized_move?(piece_at_from.type, move, board)

      vacant_trajectory = move.hovered_positions.none?{|position| board.content(position)}
      return Outcome.new(false, 'Cannot move past a piece') unless vacant_trajectory

      return Outcome.new(true, board)
    end

    def authorized_move?(piece_type, move, board)
      case piece_type
      when :pawn
        return false unless move.forward?
        move_to_enemy_piece = !board.content(move.to).nil? && board.content(move.to).color != board.content(move.from).color
        (move.vertical? && (move.distance == 1 || move.distance == 2 && move.from.y == 1)) ||
        (move.diagonal? && move.distance == 1 && move_to_enemy_piece)
      when :rook
        move.horizontal? || move.vertical?
      when :bishop
        move.diagonal?
      when :king
        (move.horizontal? || move.vertical? || move.diagonal?) && move.distance == 1
      when :queen
        move.horizontal? || move.vertical? || move.diagonal?
      when :knight
        move.l?
      end
    end
  end
end


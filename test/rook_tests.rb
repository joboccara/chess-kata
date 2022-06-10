require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/main'

class RookTests < Minitest::Test
  def test_moves_a_rook_vertically
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success Mover.move(board, 'a1', 'a3')
  end

  def test_moves_a_rook_horizontally
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success Mover.move(board, 'a1', 'c1')
  end

  def test_does_not_move_rook_diagonally
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_failure Mover.move(board, 'a1', 'b2'), 'Invalid move for rook'
  end

  def test_does_not_move_rook_past_a_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:pawn, :black))
    assert_failure Mover.move(board, 'a1', 'a4'), 'Cannot move past a piece'
  end

  def test_moves_rook_to_a_position_with_an_enemy_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'a1', 'a3')
  end

  def test_does_not_move_rook_to_a_position_with_an_ally_piece
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:rook, :white))
    assert_success board.position_piece('a3', Piece.new(:rook, :white))
    assert_failure Mover.move(board, 'a1', 'a3'), 'Cannot move to a position with an ally piece'
  end
end
require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class PawnTests < Minitest::Test
  def test_moves_a_pawn
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))

    assert_failure Mover.move(board, 'a1', 'a3'), 'No piece at starting position a1'
    assert_failure Mover.move(board, 'a2', 'a5'), 'Invalid move for pawn'

    # Move 1 up
    assert_success Mover.move(board, 'a2', 'a3')

    # Move 2 up from initial position
    assert_success Mover.move(board, 'a2', 'a4')

    assert_success board.position_piece('c3', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'c3', 'c5'), 'Invalid move for pawn'

  end

  def test_makes_a_pawn_capture_at_diagonal_left
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_success board.position_piece('a4', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'b3', 'a4')
  end

  def test_makes_a_pawn_capture_at_diagonal_right
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_success board.position_piece('c4', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'b3', 'c4')
  end

  def test_fails_a_pawn_capturing_at_diagonal_with_no_piece
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'b3', 'a4'), 'Invalid move for pawn'
    assert_failure Mover.move(board, 'b3', 'c4'), 'Invalid move for pawn'
  end

  def test_fails_a_pawn_capturing_at_diagonal_with_ally_piece
    board = TestBoard.new
    assert_success board.position_piece('b3', Piece.new(:pawn, :white))
    assert_success board.position_piece('a4', Piece.new(:pawn, :white))
    assert_success board.position_piece('c4', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'b3', 'a4'), 'Invalid move for pawn'
    assert_failure Mover.move(board, 'b3', 'c4'), 'Invalid move for pawn'
  end
end

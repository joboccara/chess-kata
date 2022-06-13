require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class PawnTests < Minitest::Test
  def test_fails_to_move_from_an_empty_position
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'b2', 'b3'), 'No piece at starting position b2'
  end

  def test_moves_a_pawn_up
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))
    assert_success Mover.move(board, 'a2', 'a3')
  end

  def test_moves_a_pawn_up_two_at_initial_position
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))
    assert_success Mover.move(board, 'a2', 'a4')
  end

  def test_fails_to_move_a_pawn_up_two_at_non_initial_position
    board = TestBoard.new
    assert_success board.position_piece('a3', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'a3', 'a5'), 'Invalid move for pawn'
  end

  # def test_fails_to_move_pawn_past_piece
  #   board = TestBoard.new
  #   assert_success board.position_piece('a2', Piece.new(:pawn, :white))
  #   assert_success board.position_piece('a3', Piece.new(:bishop, :white))
  #   assert_failure Mover.move(board, 'a2', 'a4'), 'Cannot move past a piece'
  # end

  def test_fails_to_move_a_pawn_more_than_two_up
    board = TestBoard.new
    assert_success board.position_piece('a2', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'a2', 'a5'), 'Invalid move for pawn'
  end

  def test_fails_to_move_pawn_back
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'd4', 'c3'), 'Invalid move for pawn'
    assert_failure Mover.move(board, 'd4', 'd3'), 'Invalid move for pawn'
    assert_failure Mover.move(board, 'd4', 'e3'), 'Invalid move for pawn'
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
    assert_failure Mover.move(board, 'b3', 'a4'), 'Cannot move to a position with an ally piece'
    assert_failure Mover.move(board, 'b3', 'c4'), 'Cannot move to a position with an ally piece'
  end
end

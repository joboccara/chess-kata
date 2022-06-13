require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class KingTests < Minitest::Test
  def test_does_not_move_a_king_more_than_one_cell
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_failure Mover.move(board, 'd4', 'd6'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'e6'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'f6'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'f5'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'f4'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'f3'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'f2'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'e2'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'd2'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'c2'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'b2'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'b3'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'b4'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'b5'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'b6'), 'Invalid move for king'
    assert_failure Mover.move(board, 'd4', 'c6'), 'Invalid move for king'
  end

  def test_moves_a_king_diagonally_up_and_right
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'e5')
  end

  def test_moves_a_king_to_right
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'e4')
  end

  def test_moves_a_king_diagonally_down_and_right
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'e3')
  end

  def test_moves_a_king_down
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'd3')
  end

  def test_moves_a_king_diagonally_down_and_left
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'c3')
  end

  def test_moves_a_king_to_left
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'c4')
  end

  def test_moves_a_king_diagonally_up_and_left
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'c5')
  end

  def test_moves_a_king_up
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success Mover.move(board, 'd4', 'd5')
  end

  def test_does_not_move_king_to_a_position_with_an_ally_piece
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:king, :white))
    assert_success board.position_piece('d5', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'd4', 'd5'), 'Cannot move to a position with an ally piece'
  end
end
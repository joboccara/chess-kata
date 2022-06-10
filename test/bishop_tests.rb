require 'minitest/autorun'
require_relative 'test_helpers'
require_relative '../lib/mover'
require_relative '../lib/piece'

class BishopTests < Minitest::Test
  def test_does_not_move_a_bishop_vertically
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:bishop, :white))
    assert_failure Mover.move(board, 'a1', 'a3'), 'Invalid move for bishop'
  end

  def test_does_not_move_a_bishop_horizontally
    board = TestBoard.new
    assert_success board.position_piece('a1', Piece.new(:bishop, :white))
    assert_failure Mover.move(board, 'a1', 'c1'), 'Invalid move for bishop'
  end

  def test_moves_a_bishop_diagonally_up_and_right
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success Mover.move(board, 'd4', 'f6')
  end

  def test_moves_a_bishop_diagonally_up_and_left
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success Mover.move(board, 'd4', 'b6')
  end

  def test_moves_a_bishop_diagonally_down_and_left
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success Mover.move(board, 'd4', 'b2')
  end

  def test_moves_a_bishop_diagonally_down_and_right
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success Mover.move(board, 'd4', 'f2')
  end

  def test_does_not_move_bishop_past_a_piece
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success board.position_piece('e5', Piece.new(:bishop, :white))
    assert_failure Mover.move(board, 'd4', 'f6'), 'Cannot move past a piece'
  end

  def test_moves_bishop_to_a_position_with_an_enemy_piece
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success board.position_piece('f6', Piece.new(:pawn, :black))
    assert_success Mover.move(board, 'd4', 'f6')
  end

  def test_does_not_move_bishop_to_a_position_with_an_ally_piece
    board = TestBoard.new
    assert_success board.position_piece('d4', Piece.new(:bishop, :white))
    assert_success board.position_piece('f6', Piece.new(:pawn, :white))
    assert_failure Mover.move(board, 'd4', 'f6'), 'Cannot move to a position with an ally piece'
  end
end